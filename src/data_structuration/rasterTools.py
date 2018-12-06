import gdal
import tools
import db
import numpy as np
import pandas as pd
import factory
from time import gmtime, strftime

def array_to_raster(array_list, origin, extent, resolution, tmpsave=True):
    """
    Save a raster from an array
    origin and extent are tuple
    """
    
    if tmpsave:
        t_stamp = strftime("%d-%H%M%S", gmtime())
        rand_id = str(float(numpy.random.rand(1)))[-5:]
        d = "/tmp/"+t_stamp+rand_id
    else:
        d = input("Please enter path to save raster : ")

    # You need to get those values like you did.
    ex, ey = extent
    res = resolution     
    xo, yo = origin
    projection = 'PROJCS["unnamed",PROJECTION["EPSG:4326"]]'

    driver = gdal.GetDriverByName('GTiff')
    n_band = len(array_list)
    raster = driver.Create(filename,ex,ey,n_band,gdal.GDT_Float32, )

    raster.SetGeoTransform((xo, res, 0, yo, 0, -res))  
    raster.SetProjection(projection)
    c = 0
    for array in array_list:
        c += 1
        print(c, type(array))
        raster.GetRasterBand(c).WriteArray(array)
    
    raster.FlushCache()
    return raster, raster.GetRasterBand(1)
    
 '''
RASTER functions
'''

class mono_band_raster():
    '''
    This class allows basic manipulation of single-band raster (geotiff or nc format)
    It will NOT work with multiband, please use multiband class if you need to work with multiband raster
    self.get_coord_value(geo_coord=(lat,lon)) returns value at given coordinate
    '''
    def __init__(self, path):
        self.rs = gdal.Open(path)
    def calc_pixel_coord(self, geo_coord):
        """Return floating-point value that corresponds to given point."""
        x, y = geo_coord[0], geo_coord[1]
        print(self.rs)
        forward_transform = affine.Affine.from_gdal(*self.rs.GetGeoTransform())
        reverse_transform = ~forward_transform
        px, py = reverse_transform * (x, y)
        px, py = int(px + 0.5), int(py + 0.5)
        return px, py
    
    def get_pixel_value(self, pixel_coord):
        x, y = pixel_coord[0], pixel_coord[1]
        val= float(self.rs.ReadAsArray(x,y,1,1))
        return val
    
    def get_coord_value(self, geo_coord):
        pixel_coord = self.calc_pixel_coord(geo_coord)
        pixel_value = self.get_pixel_value(pixel_coord)
        return pixel_value



class multi_band_raster():
    def __init__(self, path, metadata_path=None):
        self.rs = self.load_raster(path)
        self.band_meta = self.load_meta(metadata_path) if metadata_path else None

    def load_meta(self, path):
        #print(path)
        df = pd.read_csv(path)
        df = self.band_csv_to_value(df)
        return df

    def load_raster(self, path):
        rs = gdal.Open(path)
        return rs

    def band_csv_to_value(self, df):
        df.columns = ["band", "depth"]
        def get_band_number(x):
         return int(x[5:]) #Strips leading letters 
        def get_depth_value(x):
         return int(x[:-1]) #Strips trailing letter
        df.band = df.band.apply(get_band_number)
        df.depth = df.depth.apply(get_depth_value)
        return df
    
    def calc_pixel_coord(self, geo_coord):
        """Return floating-point value that corresponds to given point."""
        x, y = geo_coord[0], geo_coord[1]
        #print(self.rs)
        forward_transform = affine.Affine.from_gdal(*self.rs.GetGeoTransform())
        reverse_transform = ~forward_transform
        px, py = reverse_transform * (x, y)
        px, py = int(px + 0.5), int(py + 0.5)
        return px, py
    
    def get_pixel_value(self, pixel_coord, band_number):
        x, y = pixel_coord[0], pixel_coord[1]
        val= float(self.rs.GetRasterBand(band_number).ReadAsArray(x,y,1,1))
        return val
  
    def get_coord_value(self, geo_coord):
        '''
        Geocoord must be 3 values in this order x,y,z with z the depth.
        '''
        band_depth = factory.closestValue(self.band_meta.depth.values, geo_coord[2]) if len(geo_coord)==3 else None
        band_number = int(self.band_meta.loc[self.band_meta.depth==band_depth].band.values) if band_depth else 1 #If we don't specify depth, we work at surface
        
        pixel_coord = self.calc_pixel_coord(geo_coord)
        pixel_value = self.get_pixel_value(pixel_coord, band_number)
        return pixel_value



Ŕ	
*é)
:
Add
x"T
y"T
z"T"
Ttype:
2	

ArgMax

input"T
	dimension"Tidx
output"output_type" 
Ttype:
2	"
Tidxtype0:
2	"
output_typetype0	:
2	
P
Assert
	condition
	
data2T"
T
list(type)(0"
	summarizeint
E
AssignAddVariableOp
resource
value"dtype"
dtypetype
B
AssignVariableOp
resource
value"dtype"
dtypetype
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
~
BiasAddGrad
out_backprop"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
R
BroadcastGradientArgs
s0"T
s1"T
r0"T
r1"T"
Ttype0:
2	
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
š
DenseToDenseSetOperation	
set1"T	
set2"T
result_indices	
result_values"T
result_shape	"
set_operationstring"
validate_indicesbool("
Ttype:
	2	
B
Equal
x"T
y"T
z
"
Ttype:
2	

W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
^
Fill
dims"
index_type

value"T
output"T"	
Ttype"

index_typetype0:
2	
=
Greater
x"T
y"T
z
"
Ttype:
2	
B
GreaterEqual
x"T
y"T
z
"
Ttype:
2	
.
Identity

input"T
output"T"	
Ttype
?
	LessEqual
x"T
y"T
z
"
Ttype:
2	
,
Log
x"T
y"T"
Ttype:

2
p
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:
	2

Max

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
;
Maximum
x"T
y"T
z"T"
Ttype:

2	

Mean

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
N
Merge
inputs"T*N
output"T
value_index"	
Ttype"
Nint(0
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(
;
Minimum
x"T
y"T
z"T"
Ttype:

2	
=
Mul
x"T
y"T
z"T"
Ttype:
2	
.
Neg
x"T
y"T"
Ttype:

2	

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
X
PlaceholderWithDefault
input"dtype
output"dtype"
dtypetype"
shapeshape
6
Pow
x"T
y"T
z"T"
Ttype:

2	
L
PreventGradient

input"T
output"T"	
Ttype"
messagestring 
~
RandomUniform

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	
@
ReadVariableOp
resource
value"dtype"
dtypetype
>
RealDiv
x"T
y"T
z"T"
Ttype:
2	
5

Reciprocal
x"T
y"T"
Ttype:

2	
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
?
Select
	condition

t"T
e"T
output"T"	
Ttype
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
O
Size

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
9
Softmax
logits"T
softmax"T"
Ttype:
2

#SparseSoftmaxCrossEntropyWithLogits
features"T
labels"Tlabels	
loss"T
backprop"T"
Ttype:
2"
Tlabelstype0	:
2	
-
Sqrt
x"T
y"T"
Ttype:

2
1
Square
x"T
y"T"
Ttype:

2	
ö
StridedSlice

input"T
begin"Index
end"Index
strides"Index
output"T"	
Ttype"
Indextype:
2	"

begin_maskint "
end_maskint "
ellipsis_maskint "
new_axis_maskint "
shrink_axis_maskint 
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
:
Sub
x"T
y"T
z"T"
Ttype:
2	

Sum

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
M
Switch	
data"T
pred

output_false"T
output_true"T"	
Ttype
-
Tanh
x"T
y"T"
Ttype:

2
:
TanhGrad
y"T
dy"T
z"T"
Ttype:

2
c
Tile

input"T
	multiples"
Tmultiples
output"T"	
Ttype"

Tmultiplestype0:
2	

TruncatedNormal

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	
q
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape
9
VarIsInitializedOp
resource
is_initialized

&
	ZerosLike
x"T
y"T"	
Ttype"serve*1.12.02v1.12.0-0-ga6d8ffae09śÚ
p
flatten_inputPlaceholder*
dtype0*'
_output_shapes
:˙˙˙˙˙˙˙˙˙*
shape:˙˙˙˙˙˙˙˙˙
Z
flatten/ShapeShapeflatten_input*
_output_shapes
:*
T0*
out_type0
e
flatten/strided_slice/stackConst*
valueB: *
dtype0*
_output_shapes
:
g
flatten/strided_slice/stack_1Const*
_output_shapes
:*
valueB:*
dtype0
g
flatten/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ą
flatten/strided_sliceStridedSliceflatten/Shapeflatten/strided_slice/stackflatten/strided_slice/stack_1flatten/strided_slice/stack_2*
end_mask *
_output_shapes
: *
Index0*
T0*
shrink_axis_mask*

begin_mask *
ellipsis_mask *
new_axis_mask 
b
flatten/Reshape/shape/1Const*
valueB :
˙˙˙˙˙˙˙˙˙*
dtype0*
_output_shapes
: 

flatten/Reshape/shapePackflatten/strided_sliceflatten/Reshape/shape/1*
T0*

axis *
N*
_output_shapes
:

flatten/ReshapeReshapeflatten_inputflatten/Reshape/shape*
T0*
Tshape0*'
_output_shapes
:˙˙˙˙˙˙˙˙˙
Ą
/dense/kernel/Initializer/truncated_normal/shapeConst*
_class
loc:@dense/kernel*
valueB"   đ   *
dtype0*
_output_shapes
:

.dense/kernel/Initializer/truncated_normal/meanConst*
_class
loc:@dense/kernel*
valueB
 *    *
dtype0*
_output_shapes
: 

0dense/kernel/Initializer/truncated_normal/stddevConst*
_class
loc:@dense/kernel*
valueB
 *łîŃ=*
dtype0*
_output_shapes
: 
î
9dense/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal/dense/kernel/Initializer/truncated_normal/shape*
T0*
_class
loc:@dense/kernel*
seed2 *
dtype0*
_output_shapes
:	đ*

seed 
ě
-dense/kernel/Initializer/truncated_normal/mulMul9dense/kernel/Initializer/truncated_normal/TruncatedNormal0dense/kernel/Initializer/truncated_normal/stddev*
T0*
_class
loc:@dense/kernel*
_output_shapes
:	đ
Ú
)dense/kernel/Initializer/truncated_normalAdd-dense/kernel/Initializer/truncated_normal/mul.dense/kernel/Initializer/truncated_normal/mean*
_output_shapes
:	đ*
T0*
_class
loc:@dense/kernel
§
dense/kernelVarHandleOp*
shared_namedense/kernel*
_class
loc:@dense/kernel*
	container *
shape:	đ*
dtype0*
_output_shapes
: 
i
-dense/kernel/IsInitialized/VarIsInitializedOpVarIsInitializedOpdense/kernel*
_output_shapes
: 

dense/kernel/AssignAssignVariableOpdense/kernel)dense/kernel/Initializer/truncated_normal*
_class
loc:@dense/kernel*
dtype0

 dense/kernel/Read/ReadVariableOpReadVariableOpdense/kernel*
_class
loc:@dense/kernel*
dtype0*
_output_shapes
:	đ

dense/bias/Initializer/zerosConst*
_output_shapes	
:đ*
_class
loc:@dense/bias*
valueBđ*    *
dtype0


dense/biasVarHandleOp*
_class
loc:@dense/bias*
	container *
shape:đ*
dtype0*
_output_shapes
: *
shared_name
dense/bias
e
+dense/bias/IsInitialized/VarIsInitializedOpVarIsInitializedOp
dense/bias*
_output_shapes
: 
{
dense/bias/AssignAssignVariableOp
dense/biasdense/bias/Initializer/zeros*
_class
loc:@dense/bias*
dtype0

dense/bias/Read/ReadVariableOpReadVariableOp
dense/bias*
dtype0*
_output_shapes	
:đ*
_class
loc:@dense/bias
i
dense/MatMul/ReadVariableOpReadVariableOpdense/kernel*
dtype0*
_output_shapes
:	đ

dense/MatMulMatMulflatten/Reshapedense/MatMul/ReadVariableOp*
transpose_b( *
T0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙đ*
transpose_a( 
d
dense/BiasAdd/ReadVariableOpReadVariableOp
dense/bias*
dtype0*
_output_shapes	
:đ

dense/BiasAddBiasAdddense/MatMuldense/BiasAdd/ReadVariableOp*
T0*
data_formatNHWC*(
_output_shapes
:˙˙˙˙˙˙˙˙˙đ
Y
activation/TanhTanhdense/BiasAdd*
T0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙đ
Ľ
1dense_1/kernel/Initializer/truncated_normal/shapeConst*!
_class
loc:@dense_1/kernel*
valueB"đ      *
dtype0*
_output_shapes
:

0dense_1/kernel/Initializer/truncated_normal/meanConst*
dtype0*
_output_shapes
: *!
_class
loc:@dense_1/kernel*
valueB
 *    

2dense_1/kernel/Initializer/truncated_normal/stddevConst*!
_class
loc:@dense_1/kernel*
valueB
 *O¤Ť=*
dtype0*
_output_shapes
: 
ő
;dense_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal1dense_1/kernel/Initializer/truncated_normal/shape*!
_class
loc:@dense_1/kernel*
seed2 *
dtype0* 
_output_shapes
:
đ*

seed *
T0
ő
/dense_1/kernel/Initializer/truncated_normal/mulMul;dense_1/kernel/Initializer/truncated_normal/TruncatedNormal2dense_1/kernel/Initializer/truncated_normal/stddev* 
_output_shapes
:
đ*
T0*!
_class
loc:@dense_1/kernel
ă
+dense_1/kernel/Initializer/truncated_normalAdd/dense_1/kernel/Initializer/truncated_normal/mul0dense_1/kernel/Initializer/truncated_normal/mean*!
_class
loc:@dense_1/kernel* 
_output_shapes
:
đ*
T0
Ž
dense_1/kernelVarHandleOp*
dtype0*
_output_shapes
: *
shared_namedense_1/kernel*!
_class
loc:@dense_1/kernel*
	container *
shape:
đ
m
/dense_1/kernel/IsInitialized/VarIsInitializedOpVarIsInitializedOpdense_1/kernel*
_output_shapes
: 

dense_1/kernel/AssignAssignVariableOpdense_1/kernel+dense_1/kernel/Initializer/truncated_normal*!
_class
loc:@dense_1/kernel*
dtype0

"dense_1/kernel/Read/ReadVariableOpReadVariableOpdense_1/kernel*
dtype0* 
_output_shapes
:
đ*!
_class
loc:@dense_1/kernel

dense_1/bias/Initializer/zerosConst*
_class
loc:@dense_1/bias*
valueB*    *
dtype0*
_output_shapes	
:
Ł
dense_1/biasVarHandleOp*
dtype0*
_output_shapes
: *
shared_namedense_1/bias*
_class
loc:@dense_1/bias*
	container *
shape:
i
-dense_1/bias/IsInitialized/VarIsInitializedOpVarIsInitializedOpdense_1/bias*
_output_shapes
: 

dense_1/bias/AssignAssignVariableOpdense_1/biasdense_1/bias/Initializer/zeros*
_class
loc:@dense_1/bias*
dtype0

 dense_1/bias/Read/ReadVariableOpReadVariableOpdense_1/bias*
_class
loc:@dense_1/bias*
dtype0*
_output_shapes	
:
n
dense_1/MatMul/ReadVariableOpReadVariableOpdense_1/kernel*
dtype0* 
_output_shapes
:
đ
Ą
dense_1/MatMulMatMulactivation/Tanhdense_1/MatMul/ReadVariableOp*(
_output_shapes
:˙˙˙˙˙˙˙˙˙*
transpose_a( *
transpose_b( *
T0
h
dense_1/BiasAdd/ReadVariableOpReadVariableOpdense_1/bias*
dtype0*
_output_shapes	
:

dense_1/BiasAddBiasAdddense_1/MatMuldense_1/BiasAdd/ReadVariableOp*
T0*
data_formatNHWC*(
_output_shapes
:˙˙˙˙˙˙˙˙˙
]
activation_1/TanhTanhdense_1/BiasAdd*(
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0
Ł
/dense_2/kernel/Initializer/random_uniform/shapeConst*!
_class
loc:@dense_2/kernel*
valueB"   >  *
dtype0*
_output_shapes
:

-dense_2/kernel/Initializer/random_uniform/minConst*!
_class
loc:@dense_2/kernel*
valueB
 *qV˝˝*
dtype0*
_output_shapes
: 

-dense_2/kernel/Initializer/random_uniform/maxConst*!
_class
loc:@dense_2/kernel*
valueB
 *qV˝=*
dtype0*
_output_shapes
: 
í
7dense_2/kernel/Initializer/random_uniform/RandomUniformRandomUniform/dense_2/kernel/Initializer/random_uniform/shape*
T0*!
_class
loc:@dense_2/kernel*
seed2 *
dtype0* 
_output_shapes
:
ž*

seed 
Ö
-dense_2/kernel/Initializer/random_uniform/subSub-dense_2/kernel/Initializer/random_uniform/max-dense_2/kernel/Initializer/random_uniform/min*
_output_shapes
: *
T0*!
_class
loc:@dense_2/kernel
ę
-dense_2/kernel/Initializer/random_uniform/mulMul7dense_2/kernel/Initializer/random_uniform/RandomUniform-dense_2/kernel/Initializer/random_uniform/sub*
T0*!
_class
loc:@dense_2/kernel* 
_output_shapes
:
ž
Ü
)dense_2/kernel/Initializer/random_uniformAdd-dense_2/kernel/Initializer/random_uniform/mul-dense_2/kernel/Initializer/random_uniform/min*
T0*!
_class
loc:@dense_2/kernel* 
_output_shapes
:
ž
Ž
dense_2/kernelVarHandleOp*
	container *
shape:
ž*
dtype0*
_output_shapes
: *
shared_namedense_2/kernel*!
_class
loc:@dense_2/kernel
m
/dense_2/kernel/IsInitialized/VarIsInitializedOpVarIsInitializedOpdense_2/kernel*
_output_shapes
: 

dense_2/kernel/AssignAssignVariableOpdense_2/kernel)dense_2/kernel/Initializer/random_uniform*!
_class
loc:@dense_2/kernel*
dtype0

"dense_2/kernel/Read/ReadVariableOpReadVariableOpdense_2/kernel*
dtype0* 
_output_shapes
:
ž*!
_class
loc:@dense_2/kernel

dense_2/bias/Initializer/zerosConst*
_class
loc:@dense_2/bias*
valueBž*    *
dtype0*
_output_shapes	
:ž
Ł
dense_2/biasVarHandleOp*
_class
loc:@dense_2/bias*
	container *
shape:ž*
dtype0*
_output_shapes
: *
shared_namedense_2/bias
i
-dense_2/bias/IsInitialized/VarIsInitializedOpVarIsInitializedOpdense_2/bias*
_output_shapes
: 

dense_2/bias/AssignAssignVariableOpdense_2/biasdense_2/bias/Initializer/zeros*
_class
loc:@dense_2/bias*
dtype0

 dense_2/bias/Read/ReadVariableOpReadVariableOpdense_2/bias*
_output_shapes	
:ž*
_class
loc:@dense_2/bias*
dtype0
n
dense_2/MatMul/ReadVariableOpReadVariableOpdense_2/kernel*
dtype0* 
_output_shapes
:
ž
Ł
dense_2/MatMulMatMulactivation_1/Tanhdense_2/MatMul/ReadVariableOp*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž*
transpose_a( *
transpose_b( *
T0
h
dense_2/BiasAdd/ReadVariableOpReadVariableOpdense_2/bias*
dtype0*
_output_shapes	
:ž

dense_2/BiasAddBiasAdddense_2/MatMuldense_2/BiasAdd/ReadVariableOp*
T0*
data_formatNHWC*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž
c
activation_2/SoftmaxSoftmaxdense_2/BiasAdd*
T0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž

)Adam/iterations/Initializer/initial_valueConst*
_output_shapes
: *"
_class
loc:@Adam/iterations*
value	B	 R *
dtype0	
§
Adam/iterationsVarHandleOp*
dtype0	*
_output_shapes
: * 
shared_nameAdam/iterations*"
_class
loc:@Adam/iterations*
	container *
shape: 
o
0Adam/iterations/IsInitialized/VarIsInitializedOpVarIsInitializedOpAdam/iterations*
_output_shapes
: 

Adam/iterations/AssignAssignVariableOpAdam/iterations)Adam/iterations/Initializer/initial_value*
dtype0	*"
_class
loc:@Adam/iterations

#Adam/iterations/Read/ReadVariableOpReadVariableOpAdam/iterations*"
_class
loc:@Adam/iterations*
dtype0	*
_output_shapes
: 

!Adam/lr/Initializer/initial_valueConst*
_output_shapes
: *
_class
loc:@Adam/lr*
valueB
 *o:*
dtype0

Adam/lrVarHandleOp*
_class
loc:@Adam/lr*
	container *
shape: *
dtype0*
_output_shapes
: *
shared_name	Adam/lr
_
(Adam/lr/IsInitialized/VarIsInitializedOpVarIsInitializedOpAdam/lr*
_output_shapes
: 
w
Adam/lr/AssignAssignVariableOpAdam/lr!Adam/lr/Initializer/initial_value*
_class
loc:@Adam/lr*
dtype0
w
Adam/lr/Read/ReadVariableOpReadVariableOpAdam/lr*
_class
loc:@Adam/lr*
dtype0*
_output_shapes
: 

%Adam/beta_1/Initializer/initial_valueConst*
_class
loc:@Adam/beta_1*
valueB
 *fff?*
dtype0*
_output_shapes
: 

Adam/beta_1VarHandleOp*
dtype0*
_output_shapes
: *
shared_nameAdam/beta_1*
_class
loc:@Adam/beta_1*
	container *
shape: 
g
,Adam/beta_1/IsInitialized/VarIsInitializedOpVarIsInitializedOpAdam/beta_1*
_output_shapes
: 

Adam/beta_1/AssignAssignVariableOpAdam/beta_1%Adam/beta_1/Initializer/initial_value*
dtype0*
_class
loc:@Adam/beta_1

Adam/beta_1/Read/ReadVariableOpReadVariableOpAdam/beta_1*
_class
loc:@Adam/beta_1*
dtype0*
_output_shapes
: 

%Adam/beta_2/Initializer/initial_valueConst*
_class
loc:@Adam/beta_2*
valueB
 *wž?*
dtype0*
_output_shapes
: 

Adam/beta_2VarHandleOp*
_class
loc:@Adam/beta_2*
	container *
shape: *
dtype0*
_output_shapes
: *
shared_nameAdam/beta_2
g
,Adam/beta_2/IsInitialized/VarIsInitializedOpVarIsInitializedOpAdam/beta_2*
_output_shapes
: 

Adam/beta_2/AssignAssignVariableOpAdam/beta_2%Adam/beta_2/Initializer/initial_value*
_class
loc:@Adam/beta_2*
dtype0

Adam/beta_2/Read/ReadVariableOpReadVariableOpAdam/beta_2*
_class
loc:@Adam/beta_2*
dtype0*
_output_shapes
: 

$Adam/decay/Initializer/initial_valueConst*
_class
loc:@Adam/decay*
valueB
 *    *
dtype0*
_output_shapes
: 


Adam/decayVarHandleOp*
dtype0*
_output_shapes
: *
shared_name
Adam/decay*
_class
loc:@Adam/decay*
	container *
shape: 
e
+Adam/decay/IsInitialized/VarIsInitializedOpVarIsInitializedOp
Adam/decay*
_output_shapes
: 

Adam/decay/AssignAssignVariableOp
Adam/decay$Adam/decay/Initializer/initial_value*
_class
loc:@Adam/decay*
dtype0

Adam/decay/Read/ReadVariableOpReadVariableOp
Adam/decay*
_class
loc:@Adam/decay*
dtype0*
_output_shapes
: 

activation_2_targetPlaceholder*
dtype0*0
_output_shapes
:˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙*%
shape:˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙˙
R
ConstConst*
valueB*  ?*
dtype0*
_output_shapes
:

activation_2_sample_weightsPlaceholderWithDefaultConst*
dtype0*#
_output_shapes
:˙˙˙˙˙˙˙˙˙*
shape:˙˙˙˙˙˙˙˙˙
a
loss/activation_2_loss/ConstConst*
valueB
 *żÖ3*
dtype0*
_output_shapes
: 
a
loss/activation_2_loss/sub/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
~
loss/activation_2_loss/subSubloss/activation_2_loss/sub/xloss/activation_2_loss/Const*
T0*
_output_shapes
: 

,loss/activation_2_loss/clip_by_value/MinimumMinimumactivation_2/Softmaxloss/activation_2_loss/sub*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž*
T0
Ž
$loss/activation_2_loss/clip_by_valueMaximum,loss/activation_2_loss/clip_by_value/Minimumloss/activation_2_loss/Const*
T0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž
z
loss/activation_2_loss/LogLog$loss/activation_2_loss/clip_by_value*
T0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž
w
$loss/activation_2_loss/Reshape/shapeConst*
valueB:
˙˙˙˙˙˙˙˙˙*
dtype0*
_output_shapes
:
 
loss/activation_2_loss/ReshapeReshapeactivation_2_target$loss/activation_2_loss/Reshape/shape*#
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0*
Tshape0

loss/activation_2_loss/CastCastloss/activation_2_loss/Reshape*
Truncate( *#
_output_shapes
:˙˙˙˙˙˙˙˙˙*

DstT0	*

SrcT0
w
&loss/activation_2_loss/Reshape_1/shapeConst*
valueB"˙˙˙˙>  *
dtype0*
_output_shapes
:
°
 loss/activation_2_loss/Reshape_1Reshapeloss/activation_2_loss/Log&loss/activation_2_loss/Reshape_1/shape*
T0*
Tshape0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž

@loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/ShapeShapeloss/activation_2_loss/Cast*
T0	*
out_type0*
_output_shapes
:

^loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits#SparseSoftmaxCrossEntropyWithLogits loss/activation_2_loss/Reshape_1loss/activation_2_loss/Cast*
T0*7
_output_shapes%
#:˙˙˙˙˙˙˙˙˙:˙˙˙˙˙˙˙˙˙ž*
Tlabels0	
Ś
Kloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shapeShapeactivation_2_sample_weights*
T0*
out_type0*
_output_shapes
:

Jloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/rankConst*
value	B :*
dtype0*
_output_shapes
: 
č
Jloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shapeShape^loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits*
_output_shapes
:*
T0*
out_type0

Iloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/rankConst*
value	B :*
dtype0*
_output_shapes
: 

Iloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalar/xConst*
value	B : *
dtype0*
_output_shapes
: 

Gloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalarEqualIloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalar/xJloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/rank*
T0*
_output_shapes
: 

Sloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/SwitchSwitchGloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalarGloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalar*
T0
*
_output_shapes
: : 
Ů
Uloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/switch_tIdentityUloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Switch:1*
T0
*
_output_shapes
: 
×
Uloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/switch_fIdentitySloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Switch*
T0
*
_output_shapes
: 
Ę
Tloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_idIdentityGloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalar*
T0
*
_output_shapes
: 
ý
Uloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Switch_1SwitchGloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalarTloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id*
_output_shapes
: : *
T0
*Z
_classP
NLloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalar

sloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rankEqualzloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank/Switch|loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank/Switch_1*
T0*
_output_shapes
: 
Ś
zloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank/SwitchSwitchIloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/rankTloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id*
T0*\
_classR
PNloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/values/rank*
_output_shapes
: : 
Ş
|loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank/Switch_1SwitchJloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/rankTloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id*
_output_shapes
: : *
T0*]
_classS
QOloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/rank

mloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/SwitchSwitchsloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_ranksloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank*
T0
*
_output_shapes
: : 

oloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_tIdentityoloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Switch:1*
_output_shapes
: *
T0


oloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_fIdentitymloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Switch*
_output_shapes
: *
T0


nloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_idIdentitysloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank*
_output_shapes
: *
T0

Ä
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/dimConstp^loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_t*
valueB :
˙˙˙˙˙˙˙˙˙*
dtype0*
_output_shapes
: 
ß
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims
ExpandDimsloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/Switch_1:1loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/dim*
_output_shapes

:*

Tdim0*
T0
Ŕ
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/SwitchSwitchJloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shapeTloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id*
T0*]
_classS
QOloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shape* 
_output_shapes
::

loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/Switch_1Switchloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/Switchnloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id* 
_output_shapes
::*
T0*]
_classS
QOloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shape
Ë
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_like/ShapeConstp^loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_t*
valueB"      *
dtype0*
_output_shapes
:
ź
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_like/ConstConstp^loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_t*
value	B :*
dtype0*
_output_shapes
: 
Ů
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_likeFillloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_like/Shapeloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_like/Const*

index_type0*
_output_shapes

:*
T0
¸
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/concat/axisConstp^loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_t*
value	B :*
dtype0*
_output_shapes
: 
×
~loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/concatConcatV2loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDimsloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_likeloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/concat/axis*

Tidx0*
T0*
N*
_output_shapes

:
Ć
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/dimConstp^loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_t*
valueB :
˙˙˙˙˙˙˙˙˙*
dtype0*
_output_shapes
: 
ĺ
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1
ExpandDimsloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/Switch_1:1loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/dim*
_output_shapes

:*

Tdim0*
T0
Ä
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/SwitchSwitchKloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shapeTloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id*
T0*^
_classT
RPloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shape* 
_output_shapes
::
Ą
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/Switch_1Switchloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/Switchnloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id* 
_output_shapes
::*
T0*^
_classT
RPloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shape
Ť
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/DenseToDenseSetOperationDenseToDenseSetOperationloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1~loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/concat*
set_operationa-b*
validate_indices(*
T0*<
_output_shapes*
(:˙˙˙˙˙˙˙˙˙:˙˙˙˙˙˙˙˙˙:
×
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/num_invalid_dimsSizeloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/DenseToDenseSetOperation:1*
_output_shapes
: *
T0*
out_type0
­
yloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/xConstp^loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_t*
dtype0*
_output_shapes
: *
value	B : 
§
wloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dimsEqualyloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/xloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/num_invalid_dims*
T0*
_output_shapes
: 

oloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Switch_1Switchsloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_ranknloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id*
T0
*
_class|
zxloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank*
_output_shapes
: : 

lloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/MergeMergeoloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Switch_1wloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims*
T0
*
N*
_output_shapes
: : 
Î
Rloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/MergeMergelloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/MergeWloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Switch_1:1*
T0
*
N*
_output_shapes
: : 
Ť
Closs/activation_2_loss/broadcast_weights/assert_broadcastable/ConstConst*8
value/B- B'weights can not be broadcast to values.*
dtype0*
_output_shapes
: 

Eloss/activation_2_loss/broadcast_weights/assert_broadcastable/Const_1Const*
_output_shapes
: *
valueB Bweights.shape=*
dtype0
Ł
Eloss/activation_2_loss/broadcast_weights/assert_broadcastable/Const_2Const*.
value%B# Bactivation_2_sample_weights:0*
dtype0*
_output_shapes
: 

Eloss/activation_2_loss/broadcast_weights/assert_broadcastable/Const_3Const*
valueB Bvalues.shape=*
dtype0*
_output_shapes
: 
ć
Eloss/activation_2_loss/broadcast_weights/assert_broadcastable/Const_4Const*q
valuehBf B`loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits:0*
dtype0*
_output_shapes
: 

Eloss/activation_2_loss/broadcast_weights/assert_broadcastable/Const_5Const*
dtype0*
_output_shapes
: *
valueB B
is_scalar=
Ľ
Ploss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/SwitchSwitchRloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/MergeRloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Merge*
T0
*
_output_shapes
: : 
Ó
Rloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_tIdentityRloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Switch:1*
T0
*
_output_shapes
: 
Ń
Rloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_fIdentityPloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Switch*
_output_shapes
: *
T0

Ň
Qloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_idIdentityRloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Merge*
_output_shapes
: *
T0

Ť
Nloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/NoOpNoOpS^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_t

\loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/control_dependencyIdentityRloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_tO^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/NoOp*
T0
*e
_class[
YWloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_t*
_output_shapes
: 

Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_0ConstS^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_f*8
value/B- B'weights can not be broadcast to values.*
dtype0*
_output_shapes
: 
ű
Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_1ConstS^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_f*
valueB Bweights.shape=*
dtype0*
_output_shapes
: 

Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_2ConstS^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_f*.
value%B# Bactivation_2_sample_weights:0*
dtype0*
_output_shapes
: 
ú
Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_4ConstS^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_f*
_output_shapes
: *
valueB Bvalues.shape=*
dtype0
Í
Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_5ConstS^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_f*q
valuehBf B`loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits:0*
dtype0*
_output_shapes
: 
÷
Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_7ConstS^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_f*
valueB B
is_scalar=*
dtype0*
_output_shapes
: 
˙
Ploss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/AssertAssertWloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/SwitchWloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_0Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_1Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_2Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_1Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_4Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_5Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_2Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_7Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_3*
T
2	
*
	summarize

Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/SwitchSwitchRloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/MergeQloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id*e
_class[
YWloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Merge*
_output_shapes
: : *
T0


Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_1SwitchKloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shapeQloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id* 
_output_shapes
::*
T0*^
_classT
RPloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shape

Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_2SwitchJloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shapeQloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id*
T0*]
_classS
QOloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shape* 
_output_shapes
::
ţ
Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_3SwitchGloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalarQloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id*
T0
*Z
_classP
NLloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalar*
_output_shapes
: : 

^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/control_dependency_1IdentityRloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_fQ^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert*
T0
*e
_class[
YWloc:@loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_f*
_output_shapes
: 
Â
Oloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/MergeMerge^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/control_dependency_1\loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/control_dependency*
T0
*
N*
_output_shapes
: : 
¨
8loss/activation_2_loss/broadcast_weights/ones_like/ShapeShape^loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogitsP^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Merge*
_output_shapes
:*
T0*
out_type0
Ď
8loss/activation_2_loss/broadcast_weights/ones_like/ConstConstP^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Merge*
valueB
 *  ?*
dtype0*
_output_shapes
: 
î
2loss/activation_2_loss/broadcast_weights/ones_likeFill8loss/activation_2_loss/broadcast_weights/ones_like/Shape8loss/activation_2_loss/broadcast_weights/ones_like/Const*#
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0*

index_type0
Ž
(loss/activation_2_loss/broadcast_weightsMulactivation_2_sample_weights2loss/activation_2_loss/broadcast_weights/ones_like*
T0*#
_output_shapes
:˙˙˙˙˙˙˙˙˙
Ů
loss/activation_2_loss/MulMul^loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits(loss/activation_2_loss/broadcast_weights*
T0*#
_output_shapes
:˙˙˙˙˙˙˙˙˙
h
loss/activation_2_loss/Const_1Const*
valueB: *
dtype0*
_output_shapes
:

loss/activation_2_loss/SumSumloss/activation_2_loss/Mulloss/activation_2_loss/Const_1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
h
loss/activation_2_loss/Const_2Const*
valueB: *
dtype0*
_output_shapes
:
Ť
loss/activation_2_loss/Sum_1Sum(loss/activation_2_loss/broadcast_weightsloss/activation_2_loss/Const_2*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0

loss/activation_2_loss/truedivRealDivloss/activation_2_loss/Sumloss/activation_2_loss/Sum_1*
T0*
_output_shapes
: 
f
!loss/activation_2_loss/zeros_likeConst*
valueB
 *    *
dtype0*
_output_shapes
: 

loss/activation_2_loss/GreaterGreaterloss/activation_2_loss/Sum_1!loss/activation_2_loss/zeros_like*
_output_shapes
: *
T0
Ť
loss/activation_2_loss/SelectSelectloss/activation_2_loss/Greaterloss/activation_2_loss/truediv!loss/activation_2_loss/zeros_like*
T0*
_output_shapes
: 
a
loss/activation_2_loss/Const_3Const*
valueB *
dtype0*
_output_shapes
: 
 
loss/activation_2_loss/MeanMeanloss/activation_2_loss/Selectloss/activation_2_loss/Const_3*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
O

loss/mul/xConst*
dtype0*
_output_shapes
: *
valueB
 *  ?
Y
loss/mulMul
loss/mul/xloss/activation_2_loss/Mean*
T0*
_output_shapes
: 
l
!metrics/acc/Max/reduction_indicesConst*
valueB :
˙˙˙˙˙˙˙˙˙*
dtype0*
_output_shapes
: 

metrics/acc/MaxMaxactivation_2_target!metrics/acc/Max/reduction_indices*
T0*#
_output_shapes
:˙˙˙˙˙˙˙˙˙*
	keep_dims( *

Tidx0
g
metrics/acc/ArgMax/dimensionConst*
valueB :
˙˙˙˙˙˙˙˙˙*
dtype0*
_output_shapes
: 

metrics/acc/ArgMaxArgMaxactivation_2/Softmaxmetrics/acc/ArgMax/dimension*
T0*
output_type0	*#
_output_shapes
:˙˙˙˙˙˙˙˙˙*

Tidx0
y
metrics/acc/CastCastmetrics/acc/ArgMax*

SrcT0	*
Truncate( *#
_output_shapes
:˙˙˙˙˙˙˙˙˙*

DstT0
k
metrics/acc/EqualEqualmetrics/acc/Maxmetrics/acc/Cast*#
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0
z
metrics/acc/Cast_1Castmetrics/acc/Equal*

SrcT0
*
Truncate( *#
_output_shapes
:˙˙˙˙˙˙˙˙˙*

DstT0
[
metrics/acc/ConstConst*
valueB: *
dtype0*
_output_shapes
:
}
metrics/acc/MeanMeanmetrics/acc/Cast_1metrics/acc/Const*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
}
training/Adam/gradients/ShapeConst*
dtype0*
_output_shapes
: *
_class
loc:@loss/mul*
valueB 

!training/Adam/gradients/grad_ys_0Const*
_class
loc:@loss/mul*
valueB
 *  ?*
dtype0*
_output_shapes
: 
ś
training/Adam/gradients/FillFilltraining/Adam/gradients/Shape!training/Adam/gradients/grad_ys_0*
T0*
_class
loc:@loss/mul*

index_type0*
_output_shapes
: 
Š
)training/Adam/gradients/loss/mul_grad/MulMultraining/Adam/gradients/Fillloss/activation_2_loss/Mean*
T0*
_class
loc:@loss/mul*
_output_shapes
: 

+training/Adam/gradients/loss/mul_grad/Mul_1Multraining/Adam/gradients/Fill
loss/mul/x*
T0*
_class
loc:@loss/mul*
_output_shapes
: 
š
Ftraining/Adam/gradients/loss/activation_2_loss/Mean_grad/Reshape/shapeConst*
dtype0*
_output_shapes
: *.
_class$
" loc:@loss/activation_2_loss/Mean*
valueB 

@training/Adam/gradients/loss/activation_2_loss/Mean_grad/ReshapeReshape+training/Adam/gradients/loss/mul_grad/Mul_1Ftraining/Adam/gradients/loss/activation_2_loss/Mean_grad/Reshape/shape*
T0*.
_class$
" loc:@loss/activation_2_loss/Mean*
Tshape0*
_output_shapes
: 
ą
>training/Adam/gradients/loss/activation_2_loss/Mean_grad/ConstConst*.
_class$
" loc:@loss/activation_2_loss/Mean*
valueB *
dtype0*
_output_shapes
: 
Ş
=training/Adam/gradients/loss/activation_2_loss/Mean_grad/TileTile@training/Adam/gradients/loss/activation_2_loss/Mean_grad/Reshape>training/Adam/gradients/loss/activation_2_loss/Mean_grad/Const*
_output_shapes
: *

Tmultiples0*
T0*.
_class$
" loc:@loss/activation_2_loss/Mean
ľ
@training/Adam/gradients/loss/activation_2_loss/Mean_grad/Const_1Const*.
_class$
" loc:@loss/activation_2_loss/Mean*
valueB
 *  ?*
dtype0*
_output_shapes
: 

@training/Adam/gradients/loss/activation_2_loss/Mean_grad/truedivRealDiv=training/Adam/gradients/loss/activation_2_loss/Mean_grad/Tile@training/Adam/gradients/loss/activation_2_loss/Mean_grad/Const_1*
T0*.
_class$
" loc:@loss/activation_2_loss/Mean*
_output_shapes
: 
ź
Etraining/Adam/gradients/loss/activation_2_loss/Select_grad/zeros_likeConst*0
_class&
$"loc:@loss/activation_2_loss/Select*
valueB
 *    *
dtype0*
_output_shapes
: 
Ç
Atraining/Adam/gradients/loss/activation_2_loss/Select_grad/SelectSelectloss/activation_2_loss/Greater@training/Adam/gradients/loss/activation_2_loss/Mean_grad/truedivEtraining/Adam/gradients/loss/activation_2_loss/Select_grad/zeros_like*
T0*0
_class&
$"loc:@loss/activation_2_loss/Select*
_output_shapes
: 
É
Ctraining/Adam/gradients/loss/activation_2_loss/Select_grad/Select_1Selectloss/activation_2_loss/GreaterEtraining/Adam/gradients/loss/activation_2_loss/Select_grad/zeros_like@training/Adam/gradients/loss/activation_2_loss/Mean_grad/truediv*0
_class&
$"loc:@loss/activation_2_loss/Select*
_output_shapes
: *
T0
ˇ
Atraining/Adam/gradients/loss/activation_2_loss/truediv_grad/ShapeConst*1
_class'
%#loc:@loss/activation_2_loss/truediv*
valueB *
dtype0*
_output_shapes
: 
š
Ctraining/Adam/gradients/loss/activation_2_loss/truediv_grad/Shape_1Const*1
_class'
%#loc:@loss/activation_2_loss/truediv*
valueB *
dtype0*
_output_shapes
: 
â
Qtraining/Adam/gradients/loss/activation_2_loss/truediv_grad/BroadcastGradientArgsBroadcastGradientArgsAtraining/Adam/gradients/loss/activation_2_loss/truediv_grad/ShapeCtraining/Adam/gradients/loss/activation_2_loss/truediv_grad/Shape_1*
T0*1
_class'
%#loc:@loss/activation_2_loss/truediv*2
_output_shapes 
:˙˙˙˙˙˙˙˙˙:˙˙˙˙˙˙˙˙˙

Ctraining/Adam/gradients/loss/activation_2_loss/truediv_grad/RealDivRealDivAtraining/Adam/gradients/loss/activation_2_loss/Select_grad/Selectloss/activation_2_loss/Sum_1*1
_class'
%#loc:@loss/activation_2_loss/truediv*
_output_shapes
: *
T0
Ď
?training/Adam/gradients/loss/activation_2_loss/truediv_grad/SumSumCtraining/Adam/gradients/loss/activation_2_loss/truediv_grad/RealDivQtraining/Adam/gradients/loss/activation_2_loss/truediv_grad/BroadcastGradientArgs*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0*1
_class'
%#loc:@loss/activation_2_loss/truediv
´
Ctraining/Adam/gradients/loss/activation_2_loss/truediv_grad/ReshapeReshape?training/Adam/gradients/loss/activation_2_loss/truediv_grad/SumAtraining/Adam/gradients/loss/activation_2_loss/truediv_grad/Shape*
T0*1
_class'
%#loc:@loss/activation_2_loss/truediv*
Tshape0*
_output_shapes
: 
ś
?training/Adam/gradients/loss/activation_2_loss/truediv_grad/NegNegloss/activation_2_loss/Sum*
T0*1
_class'
%#loc:@loss/activation_2_loss/truediv*
_output_shapes
: 

Etraining/Adam/gradients/loss/activation_2_loss/truediv_grad/RealDiv_1RealDiv?training/Adam/gradients/loss/activation_2_loss/truediv_grad/Negloss/activation_2_loss/Sum_1*
T0*1
_class'
%#loc:@loss/activation_2_loss/truediv*
_output_shapes
: 

Etraining/Adam/gradients/loss/activation_2_loss/truediv_grad/RealDiv_2RealDivEtraining/Adam/gradients/loss/activation_2_loss/truediv_grad/RealDiv_1loss/activation_2_loss/Sum_1*
T0*1
_class'
%#loc:@loss/activation_2_loss/truediv*
_output_shapes
: 
¤
?training/Adam/gradients/loss/activation_2_loss/truediv_grad/mulMulAtraining/Adam/gradients/loss/activation_2_loss/Select_grad/SelectEtraining/Adam/gradients/loss/activation_2_loss/truediv_grad/RealDiv_2*
T0*1
_class'
%#loc:@loss/activation_2_loss/truediv*
_output_shapes
: 
Ď
Atraining/Adam/gradients/loss/activation_2_loss/truediv_grad/Sum_1Sum?training/Adam/gradients/loss/activation_2_loss/truediv_grad/mulStraining/Adam/gradients/loss/activation_2_loss/truediv_grad/BroadcastGradientArgs:1*1
_class'
%#loc:@loss/activation_2_loss/truediv*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
ş
Etraining/Adam/gradients/loss/activation_2_loss/truediv_grad/Reshape_1ReshapeAtraining/Adam/gradients/loss/activation_2_loss/truediv_grad/Sum_1Ctraining/Adam/gradients/loss/activation_2_loss/truediv_grad/Shape_1*
T0*1
_class'
%#loc:@loss/activation_2_loss/truediv*
Tshape0*
_output_shapes
: 
ž
Etraining/Adam/gradients/loss/activation_2_loss/Sum_grad/Reshape/shapeConst*-
_class#
!loc:@loss/activation_2_loss/Sum*
valueB:*
dtype0*
_output_shapes
:
¸
?training/Adam/gradients/loss/activation_2_loss/Sum_grad/ReshapeReshapeCtraining/Adam/gradients/loss/activation_2_loss/truediv_grad/ReshapeEtraining/Adam/gradients/loss/activation_2_loss/Sum_grad/Reshape/shape*
_output_shapes
:*
T0*-
_class#
!loc:@loss/activation_2_loss/Sum*
Tshape0
Ć
=training/Adam/gradients/loss/activation_2_loss/Sum_grad/ShapeShapeloss/activation_2_loss/Mul*-
_class#
!loc:@loss/activation_2_loss/Sum*
out_type0*
_output_shapes
:*
T0
ł
<training/Adam/gradients/loss/activation_2_loss/Sum_grad/TileTile?training/Adam/gradients/loss/activation_2_loss/Sum_grad/Reshape=training/Adam/gradients/loss/activation_2_loss/Sum_grad/Shape*

Tmultiples0*
T0*-
_class#
!loc:@loss/activation_2_loss/Sum*#
_output_shapes
:˙˙˙˙˙˙˙˙˙

=training/Adam/gradients/loss/activation_2_loss/Mul_grad/ShapeShape^loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits*
T0*-
_class#
!loc:@loss/activation_2_loss/Mul*
out_type0*
_output_shapes
:
Ö
?training/Adam/gradients/loss/activation_2_loss/Mul_grad/Shape_1Shape(loss/activation_2_loss/broadcast_weights*
_output_shapes
:*
T0*-
_class#
!loc:@loss/activation_2_loss/Mul*
out_type0
Ň
Mtraining/Adam/gradients/loss/activation_2_loss/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs=training/Adam/gradients/loss/activation_2_loss/Mul_grad/Shape?training/Adam/gradients/loss/activation_2_loss/Mul_grad/Shape_1*
T0*-
_class#
!loc:@loss/activation_2_loss/Mul*2
_output_shapes 
:˙˙˙˙˙˙˙˙˙:˙˙˙˙˙˙˙˙˙

;training/Adam/gradients/loss/activation_2_loss/Mul_grad/MulMul<training/Adam/gradients/loss/activation_2_loss/Sum_grad/Tile(loss/activation_2_loss/broadcast_weights*
T0*-
_class#
!loc:@loss/activation_2_loss/Mul*#
_output_shapes
:˙˙˙˙˙˙˙˙˙
˝
;training/Adam/gradients/loss/activation_2_loss/Mul_grad/SumSum;training/Adam/gradients/loss/activation_2_loss/Mul_grad/MulMtraining/Adam/gradients/loss/activation_2_loss/Mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0*-
_class#
!loc:@loss/activation_2_loss/Mul
ą
?training/Adam/gradients/loss/activation_2_loss/Mul_grad/ReshapeReshape;training/Adam/gradients/loss/activation_2_loss/Mul_grad/Sum=training/Adam/gradients/loss/activation_2_loss/Mul_grad/Shape*
T0*-
_class#
!loc:@loss/activation_2_loss/Mul*
Tshape0*#
_output_shapes
:˙˙˙˙˙˙˙˙˙
ż
=training/Adam/gradients/loss/activation_2_loss/Mul_grad/Mul_1Mul^loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits<training/Adam/gradients/loss/activation_2_loss/Sum_grad/Tile*#
_output_shapes
:˙˙˙˙˙˙˙˙˙*
T0*-
_class#
!loc:@loss/activation_2_loss/Mul
Ă
=training/Adam/gradients/loss/activation_2_loss/Mul_grad/Sum_1Sum=training/Adam/gradients/loss/activation_2_loss/Mul_grad/Mul_1Otraining/Adam/gradients/loss/activation_2_loss/Mul_grad/BroadcastGradientArgs:1*
T0*-
_class#
!loc:@loss/activation_2_loss/Mul*
_output_shapes
:*
	keep_dims( *

Tidx0
ˇ
Atraining/Adam/gradients/loss/activation_2_loss/Mul_grad/Reshape_1Reshape=training/Adam/gradients/loss/activation_2_loss/Mul_grad/Sum_1?training/Adam/gradients/loss/activation_2_loss/Mul_grad/Shape_1*
T0*-
_class#
!loc:@loss/activation_2_loss/Mul*
Tshape0*#
_output_shapes
:˙˙˙˙˙˙˙˙˙
ˇ
"training/Adam/gradients/zeros_like	ZerosLike`loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits:1*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž*
T0*q
_classg
ecloc:@loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits
Ţ
training/Adam/gradients/loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits_grad/PreventGradientPreventGradient`loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits:1*q
_classg
ecloc:@loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž*´
message¨ĽCurrently there is no way to take the second derivative of sparse_softmax_cross_entropy_with_logits due to the fused implementation's interaction with tf.gradients()*
T0
É
training/Adam/gradients/loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits_grad/ExpandDims/dimConst*q
_classg
ecloc:@loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits*
valueB :
˙˙˙˙˙˙˙˙˙*
dtype0*
_output_shapes
: 

training/Adam/gradients/loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits_grad/ExpandDims
ExpandDims?training/Adam/gradients/loss/activation_2_loss/Mul_grad/Reshapetraining/Adam/gradients/loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits_grad/ExpandDims/dim*q
_classg
ecloc:@loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits*'
_output_shapes
:˙˙˙˙˙˙˙˙˙*

Tdim0*
T0
Ă
training/Adam/gradients/loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits_grad/mulMultraining/Adam/gradients/loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits_grad/ExpandDimstraining/Adam/gradients/loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits_grad/PreventGradient*
T0*q
_classg
ecloc:@loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž
Ň
Ctraining/Adam/gradients/loss/activation_2_loss/Reshape_1_grad/ShapeShapeloss/activation_2_loss/Log*
_output_shapes
:*
T0*3
_class)
'%loc:@loss/activation_2_loss/Reshape_1*
out_type0

Etraining/Adam/gradients/loss/activation_2_loss/Reshape_1_grad/ReshapeReshapetraining/Adam/gradients/loss/activation_2_loss/SparseSoftmaxCrossEntropyWithLogits/SparseSoftmaxCrossEntropyWithLogits_grad/mulCtraining/Adam/gradients/loss/activation_2_loss/Reshape_1_grad/Shape*3
_class)
'%loc:@loss/activation_2_loss/Reshape_1*
Tshape0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž*
T0
 
Btraining/Adam/gradients/loss/activation_2_loss/Log_grad/Reciprocal
Reciprocal$loss/activation_2_loss/clip_by_valueF^training/Adam/gradients/loss/activation_2_loss/Reshape_1_grad/Reshape*
T0*-
_class#
!loc:@loss/activation_2_loss/Log*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž
Ż
;training/Adam/gradients/loss/activation_2_loss/Log_grad/mulMulEtraining/Adam/gradients/loss/activation_2_loss/Reshape_1_grad/ReshapeBtraining/Adam/gradients/loss/activation_2_loss/Log_grad/Reciprocal*
T0*-
_class#
!loc:@loss/activation_2_loss/Log*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž
ě
Gtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/ShapeShape,loss/activation_2_loss/clip_by_value/Minimum*
T0*7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*
out_type0*
_output_shapes
:
Ĺ
Itraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Shape_1Const*
dtype0*
_output_shapes
: *7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*
valueB 
ý
Itraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Shape_2Shape;training/Adam/gradients/loss/activation_2_loss/Log_grad/mul*
T0*7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*
out_type0*
_output_shapes
:
Ë
Mtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/zeros/ConstConst*
dtype0*
_output_shapes
: *7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*
valueB
 *    
ç
Gtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/zerosFillItraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Shape_2Mtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/zeros/Const*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž*
T0*7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*

index_type0

Ntraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/GreaterEqualGreaterEqual,loss/activation_2_loss/clip_by_value/Minimumloss/activation_2_loss/Const*
T0*7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž
ú
Wtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgsGtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/ShapeItraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Shape_1*
T0*7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*2
_output_shapes 
:˙˙˙˙˙˙˙˙˙:˙˙˙˙˙˙˙˙˙

Htraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/SelectSelectNtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/GreaterEqual;training/Adam/gradients/loss/activation_2_loss/Log_grad/mulGtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/zeros*7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž*
T0

Jtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Select_1SelectNtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/GreaterEqualGtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/zeros;training/Adam/gradients/loss/activation_2_loss/Log_grad/mul*
T0*7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž
č
Etraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/SumSumHtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/SelectWtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/BroadcastGradientArgs*
T0*7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*
_output_shapes
:*
	keep_dims( *

Tidx0
Ţ
Itraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/ReshapeReshapeEtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/SumGtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Shape*
T0*7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*
Tshape0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž
î
Gtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Sum_1SumJtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Select_1Ytraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*
_output_shapes
:
Ň
Ktraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Reshape_1ReshapeGtraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Sum_1Itraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Shape_1*
_output_shapes
: *
T0*7
_class-
+)loc:@loss/activation_2_loss/clip_by_value*
Tshape0
ä
Otraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/ShapeShapeactivation_2/Softmax*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*
out_type0*
_output_shapes
:*
T0
Ő
Qtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Shape_1Const*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*
valueB *
dtype0*
_output_shapes
: 

Qtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Shape_2ShapeItraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Reshape*
T0*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*
out_type0*
_output_shapes
:
Ű
Utraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/zeros/ConstConst*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*
valueB
 *    *
dtype0*
_output_shapes
: 

Otraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/zerosFillQtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Shape_2Utraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/zeros/Const*
T0*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*

index_type0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž

Straining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/LessEqual	LessEqualactivation_2/Softmaxloss/activation_2_loss/sub*
T0*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž

_training/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgsOtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/ShapeQtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Shape_1*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*2
_output_shapes 
:˙˙˙˙˙˙˙˙˙:˙˙˙˙˙˙˙˙˙*
T0
ż
Ptraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/SelectSelectStraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/LessEqualItraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/ReshapeOtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/zeros*
T0*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž
Á
Rtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Select_1SelectStraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/LessEqualOtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/zerosItraining/Adam/gradients/loss/activation_2_loss/clip_by_value_grad/Reshape*
T0*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž

Mtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/SumSumPtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Select_training/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*
_output_shapes
:*
	keep_dims( *

Tidx0
ţ
Qtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/ReshapeReshapeMtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/SumOtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Shape*
T0*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*
Tshape0*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž

Otraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Sum_1SumRtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Select_1atraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*
_output_shapes
:*
	keep_dims( *

Tidx0
ň
Straining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Reshape_1ReshapeOtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Sum_1Qtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Shape_1*
_output_shapes
: *
T0*?
_class5
31loc:@loss/activation_2_loss/clip_by_value/Minimum*
Tshape0

5training/Adam/gradients/activation_2/Softmax_grad/mulMulQtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Reshapeactivation_2/Softmax*
T0*'
_class
loc:@activation_2/Softmax*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž
ť
Gtraining/Adam/gradients/activation_2/Softmax_grad/Sum/reduction_indicesConst*
dtype0*
_output_shapes
: *'
_class
loc:@activation_2/Softmax*
valueB :
˙˙˙˙˙˙˙˙˙
´
5training/Adam/gradients/activation_2/Softmax_grad/SumSum5training/Adam/gradients/activation_2/Softmax_grad/mulGtraining/Adam/gradients/activation_2/Softmax_grad/Sum/reduction_indices*
T0*'
_class
loc:@activation_2/Softmax*'
_output_shapes
:˙˙˙˙˙˙˙˙˙*
	keep_dims(*

Tidx0
˘
5training/Adam/gradients/activation_2/Softmax_grad/subSubQtraining/Adam/gradients/loss/activation_2_loss/clip_by_value/Minimum_grad/Reshape5training/Adam/gradients/activation_2/Softmax_grad/Sum*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž*
T0*'
_class
loc:@activation_2/Softmax
ç
7training/Adam/gradients/activation_2/Softmax_grad/mul_1Mul5training/Adam/gradients/activation_2/Softmax_grad/subactivation_2/Softmax*(
_output_shapes
:˙˙˙˙˙˙˙˙˙ž*
T0*'
_class
loc:@activation_2/Softmax
á
8training/Adam/gradients/dense_2/BiasAdd_grad/BiasAddGradBiasAddGrad7training/Adam/gradients/activation_2/Softmax_grad/mul_1*
T0*"
_class
loc:@dense_2/BiasAdd*
data_formatNHWC*
_output_shapes	
:ž

2training/Adam/gradients/dense_2/MatMul_grad/MatMulMatMul7training/Adam/gradients/activation_2/Softmax_grad/mul_1dense_2/MatMul/ReadVariableOp*
T0*!
_class
loc:@dense_2/MatMul*(
_output_shapes
:˙˙˙˙˙˙˙˙˙*
transpose_a( *
transpose_b(
ţ
4training/Adam/gradients/dense_2/MatMul_grad/MatMul_1MatMulactivation_1/Tanh7training/Adam/gradients/activation_2/Softmax_grad/mul_1*
T0*!
_class
loc:@dense_2/MatMul* 
_output_shapes
:
ž*
transpose_a(*
transpose_b( 
ă
7training/Adam/gradients/activation_1/Tanh_grad/TanhGradTanhGradactivation_1/Tanh2training/Adam/gradients/dense_2/MatMul_grad/MatMul*
T0*$
_class
loc:@activation_1/Tanh*(
_output_shapes
:˙˙˙˙˙˙˙˙˙
á
8training/Adam/gradients/dense_1/BiasAdd_grad/BiasAddGradBiasAddGrad7training/Adam/gradients/activation_1/Tanh_grad/TanhGrad*"
_class
loc:@dense_1/BiasAdd*
data_formatNHWC*
_output_shapes	
:*
T0

2training/Adam/gradients/dense_1/MatMul_grad/MatMulMatMul7training/Adam/gradients/activation_1/Tanh_grad/TanhGraddense_1/MatMul/ReadVariableOp*
transpose_b(*
T0*!
_class
loc:@dense_1/MatMul*(
_output_shapes
:˙˙˙˙˙˙˙˙˙đ*
transpose_a( 
ü
4training/Adam/gradients/dense_1/MatMul_grad/MatMul_1MatMulactivation/Tanh7training/Adam/gradients/activation_1/Tanh_grad/TanhGrad*
T0*!
_class
loc:@dense_1/MatMul* 
_output_shapes
:
đ*
transpose_a(*
transpose_b( 
Ý
5training/Adam/gradients/activation/Tanh_grad/TanhGradTanhGradactivation/Tanh2training/Adam/gradients/dense_1/MatMul_grad/MatMul*
T0*"
_class
loc:@activation/Tanh*(
_output_shapes
:˙˙˙˙˙˙˙˙˙đ
Ű
6training/Adam/gradients/dense/BiasAdd_grad/BiasAddGradBiasAddGrad5training/Adam/gradients/activation/Tanh_grad/TanhGrad*
T0* 
_class
loc:@dense/BiasAdd*
data_formatNHWC*
_output_shapes	
:đ

0training/Adam/gradients/dense/MatMul_grad/MatMulMatMul5training/Adam/gradients/activation/Tanh_grad/TanhGraddense/MatMul/ReadVariableOp*
T0*
_class
loc:@dense/MatMul*'
_output_shapes
:˙˙˙˙˙˙˙˙˙*
transpose_a( *
transpose_b(
ő
2training/Adam/gradients/dense/MatMul_grad/MatMul_1MatMulflatten/Reshape5training/Adam/gradients/activation/Tanh_grad/TanhGrad*
T0*
_class
loc:@dense/MatMul*
_output_shapes
:	đ*
transpose_a(*
transpose_b( 
U
training/Adam/ConstConst*
value	B	 R*
dtype0	*
_output_shapes
: 
k
!training/Adam/AssignAddVariableOpAssignAddVariableOpAdam/iterationstraining/Adam/Const*
dtype0	

training/Adam/ReadVariableOpReadVariableOpAdam/iterations"^training/Adam/AssignAddVariableOp*
_output_shapes
: *
dtype0	
i
!training/Adam/Cast/ReadVariableOpReadVariableOpAdam/iterations*
dtype0	*
_output_shapes
: 
}
training/Adam/CastCast!training/Adam/Cast/ReadVariableOp*

SrcT0	*
Truncate( *
_output_shapes
: *

DstT0
X
training/Adam/add/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
b
training/Adam/addAddtraining/Adam/Casttraining/Adam/add/y*
T0*
_output_shapes
: 
d
 training/Adam/Pow/ReadVariableOpReadVariableOpAdam/beta_2*
dtype0*
_output_shapes
: 
n
training/Adam/PowPow training/Adam/Pow/ReadVariableOptraining/Adam/add*
T0*
_output_shapes
: 
X
training/Adam/sub/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
a
training/Adam/subSubtraining/Adam/sub/xtraining/Adam/Pow*
T0*
_output_shapes
: 
Z
training/Adam/Const_1Const*
valueB
 *    *
dtype0*
_output_shapes
: 
Z
training/Adam/Const_2Const*
valueB
 *  *
dtype0*
_output_shapes
: 
y
#training/Adam/clip_by_value/MinimumMinimumtraining/Adam/subtraining/Adam/Const_2*
_output_shapes
: *
T0

training/Adam/clip_by_valueMaximum#training/Adam/clip_by_value/Minimumtraining/Adam/Const_1*
T0*
_output_shapes
: 
X
training/Adam/SqrtSqrttraining/Adam/clip_by_value*
_output_shapes
: *
T0
f
"training/Adam/Pow_1/ReadVariableOpReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
r
training/Adam/Pow_1Pow"training/Adam/Pow_1/ReadVariableOptraining/Adam/add*
T0*
_output_shapes
: 
Z
training/Adam/sub_1/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
g
training/Adam/sub_1Subtraining/Adam/sub_1/xtraining/Adam/Pow_1*
T0*
_output_shapes
: 
j
training/Adam/truedivRealDivtraining/Adam/Sqrttraining/Adam/sub_1*
_output_shapes
: *
T0
^
training/Adam/ReadVariableOp_1ReadVariableOpAdam/lr*
dtype0*
_output_shapes
: 
p
training/Adam/mulMultraining/Adam/ReadVariableOp_1training/Adam/truediv*
T0*
_output_shapes
: 
t
#training/Adam/zeros/shape_as_tensorConst*
valueB"   đ   *
dtype0*
_output_shapes
:
^
training/Adam/zeros/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 

training/Adam/zerosFill#training/Adam/zeros/shape_as_tensortraining/Adam/zeros/Const*
T0*

index_type0*
_output_shapes
:	đ
Ĺ
training/Adam/VariableVarHandleOp*
dtype0*
_output_shapes
: *'
shared_nametraining/Adam/Variable*)
_class
loc:@training/Adam/Variable*
	container *
shape:	đ
}
7training/Adam/Variable/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable*
_output_shapes
: 

training/Adam/Variable/AssignAssignVariableOptraining/Adam/Variabletraining/Adam/zeros*)
_class
loc:@training/Adam/Variable*
dtype0
­
*training/Adam/Variable/Read/ReadVariableOpReadVariableOptraining/Adam/Variable*)
_class
loc:@training/Adam/Variable*
dtype0*
_output_shapes
:	đ
d
training/Adam/zeros_1Const*
valueBđ*    *
dtype0*
_output_shapes	
:đ
Ç
training/Adam/Variable_1VarHandleOp*)
shared_nametraining/Adam/Variable_1*+
_class!
loc:@training/Adam/Variable_1*
	container *
shape:đ*
dtype0*
_output_shapes
: 

9training/Adam/Variable_1/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_1*
_output_shapes
: 

training/Adam/Variable_1/AssignAssignVariableOptraining/Adam/Variable_1training/Adam/zeros_1*
dtype0*+
_class!
loc:@training/Adam/Variable_1
Ż
,training/Adam/Variable_1/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_1*+
_class!
loc:@training/Adam/Variable_1*
dtype0*
_output_shapes	
:đ
v
%training/Adam/zeros_2/shape_as_tensorConst*
valueB"đ      *
dtype0*
_output_shapes
:
`
training/Adam/zeros_2/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 

training/Adam/zeros_2Fill%training/Adam/zeros_2/shape_as_tensortraining/Adam/zeros_2/Const*
T0*

index_type0* 
_output_shapes
:
đ
Ě
training/Adam/Variable_2VarHandleOp*+
_class!
loc:@training/Adam/Variable_2*
	container *
shape:
đ*
dtype0*
_output_shapes
: *)
shared_nametraining/Adam/Variable_2

9training/Adam/Variable_2/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_2*
_output_shapes
: 

training/Adam/Variable_2/AssignAssignVariableOptraining/Adam/Variable_2training/Adam/zeros_2*+
_class!
loc:@training/Adam/Variable_2*
dtype0
´
,training/Adam/Variable_2/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_2* 
_output_shapes
:
đ*+
_class!
loc:@training/Adam/Variable_2*
dtype0
d
training/Adam/zeros_3Const*
valueB*    *
dtype0*
_output_shapes	
:
Ç
training/Adam/Variable_3VarHandleOp*
dtype0*
_output_shapes
: *)
shared_nametraining/Adam/Variable_3*+
_class!
loc:@training/Adam/Variable_3*
	container *
shape:

9training/Adam/Variable_3/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_3*
_output_shapes
: 

training/Adam/Variable_3/AssignAssignVariableOptraining/Adam/Variable_3training/Adam/zeros_3*
dtype0*+
_class!
loc:@training/Adam/Variable_3
Ż
,training/Adam/Variable_3/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_3*+
_class!
loc:@training/Adam/Variable_3*
dtype0*
_output_shapes	
:
v
%training/Adam/zeros_4/shape_as_tensorConst*
valueB"   >  *
dtype0*
_output_shapes
:
`
training/Adam/zeros_4/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 

training/Adam/zeros_4Fill%training/Adam/zeros_4/shape_as_tensortraining/Adam/zeros_4/Const*
T0*

index_type0* 
_output_shapes
:
ž
Ě
training/Adam/Variable_4VarHandleOp*)
shared_nametraining/Adam/Variable_4*+
_class!
loc:@training/Adam/Variable_4*
	container *
shape:
ž*
dtype0*
_output_shapes
: 

9training/Adam/Variable_4/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_4*
_output_shapes
: 

training/Adam/Variable_4/AssignAssignVariableOptraining/Adam/Variable_4training/Adam/zeros_4*+
_class!
loc:@training/Adam/Variable_4*
dtype0
´
,training/Adam/Variable_4/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_4*+
_class!
loc:@training/Adam/Variable_4*
dtype0* 
_output_shapes
:
ž
d
training/Adam/zeros_5Const*
valueBž*    *
dtype0*
_output_shapes	
:ž
Ç
training/Adam/Variable_5VarHandleOp*
dtype0*
_output_shapes
: *)
shared_nametraining/Adam/Variable_5*+
_class!
loc:@training/Adam/Variable_5*
	container *
shape:ž

9training/Adam/Variable_5/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_5*
_output_shapes
: 

training/Adam/Variable_5/AssignAssignVariableOptraining/Adam/Variable_5training/Adam/zeros_5*+
_class!
loc:@training/Adam/Variable_5*
dtype0
Ż
,training/Adam/Variable_5/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_5*+
_class!
loc:@training/Adam/Variable_5*
dtype0*
_output_shapes	
:ž
v
%training/Adam/zeros_6/shape_as_tensorConst*
valueB"   đ   *
dtype0*
_output_shapes
:
`
training/Adam/zeros_6/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 

training/Adam/zeros_6Fill%training/Adam/zeros_6/shape_as_tensortraining/Adam/zeros_6/Const*
T0*

index_type0*
_output_shapes
:	đ
Ë
training/Adam/Variable_6VarHandleOp*)
shared_nametraining/Adam/Variable_6*+
_class!
loc:@training/Adam/Variable_6*
	container *
shape:	đ*
dtype0*
_output_shapes
: 

9training/Adam/Variable_6/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_6*
_output_shapes
: 

training/Adam/Variable_6/AssignAssignVariableOptraining/Adam/Variable_6training/Adam/zeros_6*+
_class!
loc:@training/Adam/Variable_6*
dtype0
ł
,training/Adam/Variable_6/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_6*+
_class!
loc:@training/Adam/Variable_6*
dtype0*
_output_shapes
:	đ
d
training/Adam/zeros_7Const*
valueBđ*    *
dtype0*
_output_shapes	
:đ
Ç
training/Adam/Variable_7VarHandleOp*
dtype0*
_output_shapes
: *)
shared_nametraining/Adam/Variable_7*+
_class!
loc:@training/Adam/Variable_7*
	container *
shape:đ

9training/Adam/Variable_7/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_7*
_output_shapes
: 

training/Adam/Variable_7/AssignAssignVariableOptraining/Adam/Variable_7training/Adam/zeros_7*+
_class!
loc:@training/Adam/Variable_7*
dtype0
Ż
,training/Adam/Variable_7/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_7*
dtype0*
_output_shapes	
:đ*+
_class!
loc:@training/Adam/Variable_7
v
%training/Adam/zeros_8/shape_as_tensorConst*
valueB"đ      *
dtype0*
_output_shapes
:
`
training/Adam/zeros_8/ConstConst*
_output_shapes
: *
valueB
 *    *
dtype0

training/Adam/zeros_8Fill%training/Adam/zeros_8/shape_as_tensortraining/Adam/zeros_8/Const*
T0*

index_type0* 
_output_shapes
:
đ
Ě
training/Adam/Variable_8VarHandleOp*
dtype0*
_output_shapes
: *)
shared_nametraining/Adam/Variable_8*+
_class!
loc:@training/Adam/Variable_8*
	container *
shape:
đ

9training/Adam/Variable_8/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_8*
_output_shapes
: 

training/Adam/Variable_8/AssignAssignVariableOptraining/Adam/Variable_8training/Adam/zeros_8*+
_class!
loc:@training/Adam/Variable_8*
dtype0
´
,training/Adam/Variable_8/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_8*+
_class!
loc:@training/Adam/Variable_8*
dtype0* 
_output_shapes
:
đ
d
training/Adam/zeros_9Const*
valueB*    *
dtype0*
_output_shapes	
:
Ç
training/Adam/Variable_9VarHandleOp*)
shared_nametraining/Adam/Variable_9*+
_class!
loc:@training/Adam/Variable_9*
	container *
shape:*
dtype0*
_output_shapes
: 

9training/Adam/Variable_9/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_9*
_output_shapes
: 

training/Adam/Variable_9/AssignAssignVariableOptraining/Adam/Variable_9training/Adam/zeros_9*+
_class!
loc:@training/Adam/Variable_9*
dtype0
Ż
,training/Adam/Variable_9/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_9*+
_class!
loc:@training/Adam/Variable_9*
dtype0*
_output_shapes	
:
w
&training/Adam/zeros_10/shape_as_tensorConst*
valueB"   >  *
dtype0*
_output_shapes
:
a
training/Adam/zeros_10/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 
Ą
training/Adam/zeros_10Fill&training/Adam/zeros_10/shape_as_tensortraining/Adam/zeros_10/Const*

index_type0* 
_output_shapes
:
ž*
T0
Ď
training/Adam/Variable_10VarHandleOp*
	container *
shape:
ž*
dtype0*
_output_shapes
: **
shared_nametraining/Adam/Variable_10*,
_class"
 loc:@training/Adam/Variable_10

:training/Adam/Variable_10/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_10*
_output_shapes
: 
˘
 training/Adam/Variable_10/AssignAssignVariableOptraining/Adam/Variable_10training/Adam/zeros_10*,
_class"
 loc:@training/Adam/Variable_10*
dtype0
ˇ
-training/Adam/Variable_10/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_10*,
_class"
 loc:@training/Adam/Variable_10*
dtype0* 
_output_shapes
:
ž
e
training/Adam/zeros_11Const*
valueBž*    *
dtype0*
_output_shapes	
:ž
Ę
training/Adam/Variable_11VarHandleOp*,
_class"
 loc:@training/Adam/Variable_11*
	container *
shape:ž*
dtype0*
_output_shapes
: **
shared_nametraining/Adam/Variable_11

:training/Adam/Variable_11/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_11*
_output_shapes
: 
˘
 training/Adam/Variable_11/AssignAssignVariableOptraining/Adam/Variable_11training/Adam/zeros_11*
dtype0*,
_class"
 loc:@training/Adam/Variable_11
˛
-training/Adam/Variable_11/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_11*,
_class"
 loc:@training/Adam/Variable_11*
dtype0*
_output_shapes	
:ž
p
&training/Adam/zeros_12/shape_as_tensorConst*
dtype0*
_output_shapes
:*
valueB:
a
training/Adam/zeros_12/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 

training/Adam/zeros_12Fill&training/Adam/zeros_12/shape_as_tensortraining/Adam/zeros_12/Const*
_output_shapes
:*
T0*

index_type0
É
training/Adam/Variable_12VarHandleOp**
shared_nametraining/Adam/Variable_12*,
_class"
 loc:@training/Adam/Variable_12*
	container *
shape:*
dtype0*
_output_shapes
: 

:training/Adam/Variable_12/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_12*
_output_shapes
: 
˘
 training/Adam/Variable_12/AssignAssignVariableOptraining/Adam/Variable_12training/Adam/zeros_12*,
_class"
 loc:@training/Adam/Variable_12*
dtype0
ą
-training/Adam/Variable_12/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_12*
dtype0*
_output_shapes
:*,
_class"
 loc:@training/Adam/Variable_12
p
&training/Adam/zeros_13/shape_as_tensorConst*
valueB:*
dtype0*
_output_shapes
:
a
training/Adam/zeros_13/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 

training/Adam/zeros_13Fill&training/Adam/zeros_13/shape_as_tensortraining/Adam/zeros_13/Const*
T0*

index_type0*
_output_shapes
:
É
training/Adam/Variable_13VarHandleOp*,
_class"
 loc:@training/Adam/Variable_13*
	container *
shape:*
dtype0*
_output_shapes
: **
shared_nametraining/Adam/Variable_13

:training/Adam/Variable_13/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_13*
_output_shapes
: 
˘
 training/Adam/Variable_13/AssignAssignVariableOptraining/Adam/Variable_13training/Adam/zeros_13*,
_class"
 loc:@training/Adam/Variable_13*
dtype0
ą
-training/Adam/Variable_13/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_13*,
_class"
 loc:@training/Adam/Variable_13*
dtype0*
_output_shapes
:
p
&training/Adam/zeros_14/shape_as_tensorConst*
valueB:*
dtype0*
_output_shapes
:
a
training/Adam/zeros_14/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 

training/Adam/zeros_14Fill&training/Adam/zeros_14/shape_as_tensortraining/Adam/zeros_14/Const*
T0*

index_type0*
_output_shapes
:
É
training/Adam/Variable_14VarHandleOp*
shape:*
dtype0*
_output_shapes
: **
shared_nametraining/Adam/Variable_14*,
_class"
 loc:@training/Adam/Variable_14*
	container 

:training/Adam/Variable_14/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_14*
_output_shapes
: 
˘
 training/Adam/Variable_14/AssignAssignVariableOptraining/Adam/Variable_14training/Adam/zeros_14*,
_class"
 loc:@training/Adam/Variable_14*
dtype0
ą
-training/Adam/Variable_14/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_14*,
_class"
 loc:@training/Adam/Variable_14*
dtype0*
_output_shapes
:
p
&training/Adam/zeros_15/shape_as_tensorConst*
valueB:*
dtype0*
_output_shapes
:
a
training/Adam/zeros_15/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 

training/Adam/zeros_15Fill&training/Adam/zeros_15/shape_as_tensortraining/Adam/zeros_15/Const*
T0*

index_type0*
_output_shapes
:
É
training/Adam/Variable_15VarHandleOp*
shape:*
dtype0*
_output_shapes
: **
shared_nametraining/Adam/Variable_15*,
_class"
 loc:@training/Adam/Variable_15*
	container 

:training/Adam/Variable_15/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_15*
_output_shapes
: 
˘
 training/Adam/Variable_15/AssignAssignVariableOptraining/Adam/Variable_15training/Adam/zeros_15*,
_class"
 loc:@training/Adam/Variable_15*
dtype0
ą
-training/Adam/Variable_15/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_15*
_output_shapes
:*,
_class"
 loc:@training/Adam/Variable_15*
dtype0
p
&training/Adam/zeros_16/shape_as_tensorConst*
valueB:*
dtype0*
_output_shapes
:
a
training/Adam/zeros_16/ConstConst*
dtype0*
_output_shapes
: *
valueB
 *    

training/Adam/zeros_16Fill&training/Adam/zeros_16/shape_as_tensortraining/Adam/zeros_16/Const*
T0*

index_type0*
_output_shapes
:
É
training/Adam/Variable_16VarHandleOp*
dtype0*
_output_shapes
: **
shared_nametraining/Adam/Variable_16*,
_class"
 loc:@training/Adam/Variable_16*
	container *
shape:

:training/Adam/Variable_16/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_16*
_output_shapes
: 
˘
 training/Adam/Variable_16/AssignAssignVariableOptraining/Adam/Variable_16training/Adam/zeros_16*
dtype0*,
_class"
 loc:@training/Adam/Variable_16
ą
-training/Adam/Variable_16/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_16*,
_class"
 loc:@training/Adam/Variable_16*
dtype0*
_output_shapes
:
p
&training/Adam/zeros_17/shape_as_tensorConst*
valueB:*
dtype0*
_output_shapes
:
a
training/Adam/zeros_17/ConstConst*
valueB
 *    *
dtype0*
_output_shapes
: 

training/Adam/zeros_17Fill&training/Adam/zeros_17/shape_as_tensortraining/Adam/zeros_17/Const*
T0*

index_type0*
_output_shapes
:
É
training/Adam/Variable_17VarHandleOp**
shared_nametraining/Adam/Variable_17*,
_class"
 loc:@training/Adam/Variable_17*
	container *
shape:*
dtype0*
_output_shapes
: 

:training/Adam/Variable_17/IsInitialized/VarIsInitializedOpVarIsInitializedOptraining/Adam/Variable_17*
_output_shapes
: 
˘
 training/Adam/Variable_17/AssignAssignVariableOptraining/Adam/Variable_17training/Adam/zeros_17*,
_class"
 loc:@training/Adam/Variable_17*
dtype0
ą
-training/Adam/Variable_17/Read/ReadVariableOpReadVariableOptraining/Adam/Variable_17*,
_class"
 loc:@training/Adam/Variable_17*
dtype0*
_output_shapes
:
b
training/Adam/ReadVariableOp_2ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
z
"training/Adam/mul_1/ReadVariableOpReadVariableOptraining/Adam/Variable*
dtype0*
_output_shapes
:	đ

training/Adam/mul_1Multraining/Adam/ReadVariableOp_2"training/Adam/mul_1/ReadVariableOp*
T0*
_output_shapes
:	đ
b
training/Adam/ReadVariableOp_3ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
Z
training/Adam/sub_2/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
r
training/Adam/sub_2Subtraining/Adam/sub_2/xtraining/Adam/ReadVariableOp_3*
_output_shapes
: *
T0

training/Adam/mul_2Multraining/Adam/sub_22training/Adam/gradients/dense/MatMul_grad/MatMul_1*
T0*
_output_shapes
:	đ
n
training/Adam/add_1Addtraining/Adam/mul_1training/Adam/mul_2*
_output_shapes
:	đ*
T0
b
training/Adam/ReadVariableOp_4ReadVariableOpAdam/beta_2*
dtype0*
_output_shapes
: 
|
"training/Adam/mul_3/ReadVariableOpReadVariableOptraining/Adam/Variable_6*
dtype0*
_output_shapes
:	đ

training/Adam/mul_3Multraining/Adam/ReadVariableOp_4"training/Adam/mul_3/ReadVariableOp*
T0*
_output_shapes
:	đ
b
training/Adam/ReadVariableOp_5ReadVariableOpAdam/beta_2*
dtype0*
_output_shapes
: 
Z
training/Adam/sub_3/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
r
training/Adam/sub_3Subtraining/Adam/sub_3/xtraining/Adam/ReadVariableOp_5*
T0*
_output_shapes
: 
|
training/Adam/SquareSquare2training/Adam/gradients/dense/MatMul_grad/MatMul_1*
T0*
_output_shapes
:	đ
o
training/Adam/mul_4Multraining/Adam/sub_3training/Adam/Square*
T0*
_output_shapes
:	đ
n
training/Adam/add_2Addtraining/Adam/mul_3training/Adam/mul_4*
_output_shapes
:	đ*
T0
l
training/Adam/mul_5Multraining/Adam/multraining/Adam/add_1*
T0*
_output_shapes
:	đ
Z
training/Adam/Const_3Const*
valueB
 *    *
dtype0*
_output_shapes
: 
Z
training/Adam/Const_4Const*
valueB
 *  *
dtype0*
_output_shapes
: 

%training/Adam/clip_by_value_1/MinimumMinimumtraining/Adam/add_2training/Adam/Const_4*
T0*
_output_shapes
:	đ

training/Adam/clip_by_value_1Maximum%training/Adam/clip_by_value_1/Minimumtraining/Adam/Const_3*
T0*
_output_shapes
:	đ
e
training/Adam/Sqrt_1Sqrttraining/Adam/clip_by_value_1*
_output_shapes
:	đ*
T0
Z
training/Adam/add_3/yConst*
dtype0*
_output_shapes
: *
valueB
 *żÖ3
q
training/Adam/add_3Addtraining/Adam/Sqrt_1training/Adam/add_3/y*
_output_shapes
:	đ*
T0
v
training/Adam/truediv_1RealDivtraining/Adam/mul_5training/Adam/add_3*
T0*
_output_shapes
:	đ
l
training/Adam/ReadVariableOp_6ReadVariableOpdense/kernel*
dtype0*
_output_shapes
:	đ
}
training/Adam/sub_4Subtraining/Adam/ReadVariableOp_6training/Adam/truediv_1*
T0*
_output_shapes
:	đ
l
training/Adam/AssignVariableOpAssignVariableOptraining/Adam/Variabletraining/Adam/add_1*
dtype0

training/Adam/ReadVariableOp_7ReadVariableOptraining/Adam/Variable^training/Adam/AssignVariableOp*
dtype0*
_output_shapes
:	đ
p
 training/Adam/AssignVariableOp_1AssignVariableOptraining/Adam/Variable_6training/Adam/add_2*
dtype0

training/Adam/ReadVariableOp_8ReadVariableOptraining/Adam/Variable_6!^training/Adam/AssignVariableOp_1*
dtype0*
_output_shapes
:	đ
d
 training/Adam/AssignVariableOp_2AssignVariableOpdense/kerneltraining/Adam/sub_4*
dtype0

training/Adam/ReadVariableOp_9ReadVariableOpdense/kernel!^training/Adam/AssignVariableOp_2*
_output_shapes
:	đ*
dtype0
c
training/Adam/ReadVariableOp_10ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
x
"training/Adam/mul_6/ReadVariableOpReadVariableOptraining/Adam/Variable_1*
dtype0*
_output_shapes	
:đ

training/Adam/mul_6Multraining/Adam/ReadVariableOp_10"training/Adam/mul_6/ReadVariableOp*
T0*
_output_shapes	
:đ
c
training/Adam/ReadVariableOp_11ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
Z
training/Adam/sub_5/xConst*
dtype0*
_output_shapes
: *
valueB
 *  ?
s
training/Adam/sub_5Subtraining/Adam/sub_5/xtraining/Adam/ReadVariableOp_11*
_output_shapes
: *
T0

training/Adam/mul_7Multraining/Adam/sub_56training/Adam/gradients/dense/BiasAdd_grad/BiasAddGrad*
T0*
_output_shapes	
:đ
j
training/Adam/add_4Addtraining/Adam/mul_6training/Adam/mul_7*
T0*
_output_shapes	
:đ
c
training/Adam/ReadVariableOp_12ReadVariableOpAdam/beta_2*
dtype0*
_output_shapes
: 
x
"training/Adam/mul_8/ReadVariableOpReadVariableOptraining/Adam/Variable_7*
dtype0*
_output_shapes	
:đ

training/Adam/mul_8Multraining/Adam/ReadVariableOp_12"training/Adam/mul_8/ReadVariableOp*
_output_shapes	
:đ*
T0
c
training/Adam/ReadVariableOp_13ReadVariableOpAdam/beta_2*
dtype0*
_output_shapes
: 
Z
training/Adam/sub_6/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
s
training/Adam/sub_6Subtraining/Adam/sub_6/xtraining/Adam/ReadVariableOp_13*
_output_shapes
: *
T0
~
training/Adam/Square_1Square6training/Adam/gradients/dense/BiasAdd_grad/BiasAddGrad*
T0*
_output_shapes	
:đ
m
training/Adam/mul_9Multraining/Adam/sub_6training/Adam/Square_1*
_output_shapes	
:đ*
T0
j
training/Adam/add_5Addtraining/Adam/mul_8training/Adam/mul_9*
T0*
_output_shapes	
:đ
i
training/Adam/mul_10Multraining/Adam/multraining/Adam/add_4*
T0*
_output_shapes	
:đ
Z
training/Adam/Const_5Const*
valueB
 *    *
dtype0*
_output_shapes
: 
Z
training/Adam/Const_6Const*
valueB
 *  *
dtype0*
_output_shapes
: 

%training/Adam/clip_by_value_2/MinimumMinimumtraining/Adam/add_5training/Adam/Const_6*
T0*
_output_shapes	
:đ

training/Adam/clip_by_value_2Maximum%training/Adam/clip_by_value_2/Minimumtraining/Adam/Const_5*
T0*
_output_shapes	
:đ
a
training/Adam/Sqrt_2Sqrttraining/Adam/clip_by_value_2*
T0*
_output_shapes	
:đ
Z
training/Adam/add_6/yConst*
valueB
 *żÖ3*
dtype0*
_output_shapes
: 
m
training/Adam/add_6Addtraining/Adam/Sqrt_2training/Adam/add_6/y*
T0*
_output_shapes	
:đ
s
training/Adam/truediv_2RealDivtraining/Adam/mul_10training/Adam/add_6*
T0*
_output_shapes	
:đ
g
training/Adam/ReadVariableOp_14ReadVariableOp
dense/bias*
dtype0*
_output_shapes	
:đ
z
training/Adam/sub_7Subtraining/Adam/ReadVariableOp_14training/Adam/truediv_2*
T0*
_output_shapes	
:đ
p
 training/Adam/AssignVariableOp_3AssignVariableOptraining/Adam/Variable_1training/Adam/add_4*
dtype0

training/Adam/ReadVariableOp_15ReadVariableOptraining/Adam/Variable_1!^training/Adam/AssignVariableOp_3*
dtype0*
_output_shapes	
:đ
p
 training/Adam/AssignVariableOp_4AssignVariableOptraining/Adam/Variable_7training/Adam/add_5*
dtype0

training/Adam/ReadVariableOp_16ReadVariableOptraining/Adam/Variable_7!^training/Adam/AssignVariableOp_4*
dtype0*
_output_shapes	
:đ
b
 training/Adam/AssignVariableOp_5AssignVariableOp
dense/biastraining/Adam/sub_7*
dtype0

training/Adam/ReadVariableOp_17ReadVariableOp
dense/bias!^training/Adam/AssignVariableOp_5*
_output_shapes	
:đ*
dtype0
c
training/Adam/ReadVariableOp_18ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
~
#training/Adam/mul_11/ReadVariableOpReadVariableOptraining/Adam/Variable_2*
dtype0* 
_output_shapes
:
đ

training/Adam/mul_11Multraining/Adam/ReadVariableOp_18#training/Adam/mul_11/ReadVariableOp* 
_output_shapes
:
đ*
T0
c
training/Adam/ReadVariableOp_19ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
Z
training/Adam/sub_8/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
s
training/Adam/sub_8Subtraining/Adam/sub_8/xtraining/Adam/ReadVariableOp_19*
T0*
_output_shapes
: 

training/Adam/mul_12Multraining/Adam/sub_84training/Adam/gradients/dense_1/MatMul_grad/MatMul_1*
T0* 
_output_shapes
:
đ
q
training/Adam/add_7Addtraining/Adam/mul_11training/Adam/mul_12*
T0* 
_output_shapes
:
đ
c
training/Adam/ReadVariableOp_20ReadVariableOpAdam/beta_2*
dtype0*
_output_shapes
: 
~
#training/Adam/mul_13/ReadVariableOpReadVariableOptraining/Adam/Variable_8*
dtype0* 
_output_shapes
:
đ

training/Adam/mul_13Multraining/Adam/ReadVariableOp_20#training/Adam/mul_13/ReadVariableOp* 
_output_shapes
:
đ*
T0
c
training/Adam/ReadVariableOp_21ReadVariableOpAdam/beta_2*
_output_shapes
: *
dtype0
Z
training/Adam/sub_9/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
s
training/Adam/sub_9Subtraining/Adam/sub_9/xtraining/Adam/ReadVariableOp_21*
_output_shapes
: *
T0

training/Adam/Square_2Square4training/Adam/gradients/dense_1/MatMul_grad/MatMul_1* 
_output_shapes
:
đ*
T0
s
training/Adam/mul_14Multraining/Adam/sub_9training/Adam/Square_2*
T0* 
_output_shapes
:
đ
q
training/Adam/add_8Addtraining/Adam/mul_13training/Adam/mul_14*
T0* 
_output_shapes
:
đ
n
training/Adam/mul_15Multraining/Adam/multraining/Adam/add_7* 
_output_shapes
:
đ*
T0
Z
training/Adam/Const_7Const*
dtype0*
_output_shapes
: *
valueB
 *    
Z
training/Adam/Const_8Const*
valueB
 *  *
dtype0*
_output_shapes
: 

%training/Adam/clip_by_value_3/MinimumMinimumtraining/Adam/add_8training/Adam/Const_8*
T0* 
_output_shapes
:
đ

training/Adam/clip_by_value_3Maximum%training/Adam/clip_by_value_3/Minimumtraining/Adam/Const_7* 
_output_shapes
:
đ*
T0
f
training/Adam/Sqrt_3Sqrttraining/Adam/clip_by_value_3*
T0* 
_output_shapes
:
đ
Z
training/Adam/add_9/yConst*
dtype0*
_output_shapes
: *
valueB
 *żÖ3
r
training/Adam/add_9Addtraining/Adam/Sqrt_3training/Adam/add_9/y*
T0* 
_output_shapes
:
đ
x
training/Adam/truediv_3RealDivtraining/Adam/mul_15training/Adam/add_9*
T0* 
_output_shapes
:
đ
p
training/Adam/ReadVariableOp_22ReadVariableOpdense_1/kernel*
dtype0* 
_output_shapes
:
đ

training/Adam/sub_10Subtraining/Adam/ReadVariableOp_22training/Adam/truediv_3* 
_output_shapes
:
đ*
T0
p
 training/Adam/AssignVariableOp_6AssignVariableOptraining/Adam/Variable_2training/Adam/add_7*
dtype0

training/Adam/ReadVariableOp_23ReadVariableOptraining/Adam/Variable_2!^training/Adam/AssignVariableOp_6*
dtype0* 
_output_shapes
:
đ
p
 training/Adam/AssignVariableOp_7AssignVariableOptraining/Adam/Variable_8training/Adam/add_8*
dtype0

training/Adam/ReadVariableOp_24ReadVariableOptraining/Adam/Variable_8!^training/Adam/AssignVariableOp_7*
dtype0* 
_output_shapes
:
đ
g
 training/Adam/AssignVariableOp_8AssignVariableOpdense_1/kerneltraining/Adam/sub_10*
dtype0

training/Adam/ReadVariableOp_25ReadVariableOpdense_1/kernel!^training/Adam/AssignVariableOp_8*
dtype0* 
_output_shapes
:
đ
c
training/Adam/ReadVariableOp_26ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
y
#training/Adam/mul_16/ReadVariableOpReadVariableOptraining/Adam/Variable_3*
dtype0*
_output_shapes	
:

training/Adam/mul_16Multraining/Adam/ReadVariableOp_26#training/Adam/mul_16/ReadVariableOp*
T0*
_output_shapes	
:
c
training/Adam/ReadVariableOp_27ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
[
training/Adam/sub_11/xConst*
dtype0*
_output_shapes
: *
valueB
 *  ?
u
training/Adam/sub_11Subtraining/Adam/sub_11/xtraining/Adam/ReadVariableOp_27*
_output_shapes
: *
T0

training/Adam/mul_17Multraining/Adam/sub_118training/Adam/gradients/dense_1/BiasAdd_grad/BiasAddGrad*
T0*
_output_shapes	
:
m
training/Adam/add_10Addtraining/Adam/mul_16training/Adam/mul_17*
T0*
_output_shapes	
:
c
training/Adam/ReadVariableOp_28ReadVariableOpAdam/beta_2*
_output_shapes
: *
dtype0
y
#training/Adam/mul_18/ReadVariableOpReadVariableOptraining/Adam/Variable_9*
dtype0*
_output_shapes	
:

training/Adam/mul_18Multraining/Adam/ReadVariableOp_28#training/Adam/mul_18/ReadVariableOp*
_output_shapes	
:*
T0
c
training/Adam/ReadVariableOp_29ReadVariableOpAdam/beta_2*
_output_shapes
: *
dtype0
[
training/Adam/sub_12/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
u
training/Adam/sub_12Subtraining/Adam/sub_12/xtraining/Adam/ReadVariableOp_29*
T0*
_output_shapes
: 

training/Adam/Square_3Square8training/Adam/gradients/dense_1/BiasAdd_grad/BiasAddGrad*
T0*
_output_shapes	
:
o
training/Adam/mul_19Multraining/Adam/sub_12training/Adam/Square_3*
_output_shapes	
:*
T0
m
training/Adam/add_11Addtraining/Adam/mul_18training/Adam/mul_19*
T0*
_output_shapes	
:
j
training/Adam/mul_20Multraining/Adam/multraining/Adam/add_10*
T0*
_output_shapes	
:
Z
training/Adam/Const_9Const*
valueB
 *    *
dtype0*
_output_shapes
: 
[
training/Adam/Const_10Const*
valueB
 *  *
dtype0*
_output_shapes
: 

%training/Adam/clip_by_value_4/MinimumMinimumtraining/Adam/add_11training/Adam/Const_10*
T0*
_output_shapes	
:

training/Adam/clip_by_value_4Maximum%training/Adam/clip_by_value_4/Minimumtraining/Adam/Const_9*
T0*
_output_shapes	
:
a
training/Adam/Sqrt_4Sqrttraining/Adam/clip_by_value_4*
T0*
_output_shapes	
:
[
training/Adam/add_12/yConst*
valueB
 *żÖ3*
dtype0*
_output_shapes
: 
o
training/Adam/add_12Addtraining/Adam/Sqrt_4training/Adam/add_12/y*
T0*
_output_shapes	
:
t
training/Adam/truediv_4RealDivtraining/Adam/mul_20training/Adam/add_12*
T0*
_output_shapes	
:
i
training/Adam/ReadVariableOp_30ReadVariableOpdense_1/bias*
dtype0*
_output_shapes	
:
{
training/Adam/sub_13Subtraining/Adam/ReadVariableOp_30training/Adam/truediv_4*
T0*
_output_shapes	
:
q
 training/Adam/AssignVariableOp_9AssignVariableOptraining/Adam/Variable_3training/Adam/add_10*
dtype0

training/Adam/ReadVariableOp_31ReadVariableOptraining/Adam/Variable_3!^training/Adam/AssignVariableOp_9*
dtype0*
_output_shapes	
:
r
!training/Adam/AssignVariableOp_10AssignVariableOptraining/Adam/Variable_9training/Adam/add_11*
dtype0

training/Adam/ReadVariableOp_32ReadVariableOptraining/Adam/Variable_9"^training/Adam/AssignVariableOp_10*
_output_shapes	
:*
dtype0
f
!training/Adam/AssignVariableOp_11AssignVariableOpdense_1/biastraining/Adam/sub_13*
dtype0

training/Adam/ReadVariableOp_33ReadVariableOpdense_1/bias"^training/Adam/AssignVariableOp_11*
dtype0*
_output_shapes	
:
c
training/Adam/ReadVariableOp_34ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
~
#training/Adam/mul_21/ReadVariableOpReadVariableOptraining/Adam/Variable_4*
dtype0* 
_output_shapes
:
ž

training/Adam/mul_21Multraining/Adam/ReadVariableOp_34#training/Adam/mul_21/ReadVariableOp*
T0* 
_output_shapes
:
ž
c
training/Adam/ReadVariableOp_35ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
[
training/Adam/sub_14/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
u
training/Adam/sub_14Subtraining/Adam/sub_14/xtraining/Adam/ReadVariableOp_35*
_output_shapes
: *
T0

training/Adam/mul_22Multraining/Adam/sub_144training/Adam/gradients/dense_2/MatMul_grad/MatMul_1* 
_output_shapes
:
ž*
T0
r
training/Adam/add_13Addtraining/Adam/mul_21training/Adam/mul_22*
T0* 
_output_shapes
:
ž
c
training/Adam/ReadVariableOp_36ReadVariableOpAdam/beta_2*
dtype0*
_output_shapes
: 

#training/Adam/mul_23/ReadVariableOpReadVariableOptraining/Adam/Variable_10*
dtype0* 
_output_shapes
:
ž

training/Adam/mul_23Multraining/Adam/ReadVariableOp_36#training/Adam/mul_23/ReadVariableOp*
T0* 
_output_shapes
:
ž
c
training/Adam/ReadVariableOp_37ReadVariableOpAdam/beta_2*
dtype0*
_output_shapes
: 
[
training/Adam/sub_15/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
u
training/Adam/sub_15Subtraining/Adam/sub_15/xtraining/Adam/ReadVariableOp_37*
T0*
_output_shapes
: 

training/Adam/Square_4Square4training/Adam/gradients/dense_2/MatMul_grad/MatMul_1* 
_output_shapes
:
ž*
T0
t
training/Adam/mul_24Multraining/Adam/sub_15training/Adam/Square_4* 
_output_shapes
:
ž*
T0
r
training/Adam/add_14Addtraining/Adam/mul_23training/Adam/mul_24* 
_output_shapes
:
ž*
T0
o
training/Adam/mul_25Multraining/Adam/multraining/Adam/add_13* 
_output_shapes
:
ž*
T0
[
training/Adam/Const_11Const*
valueB
 *    *
dtype0*
_output_shapes
: 
[
training/Adam/Const_12Const*
valueB
 *  *
dtype0*
_output_shapes
: 

%training/Adam/clip_by_value_5/MinimumMinimumtraining/Adam/add_14training/Adam/Const_12*
T0* 
_output_shapes
:
ž

training/Adam/clip_by_value_5Maximum%training/Adam/clip_by_value_5/Minimumtraining/Adam/Const_11*
T0* 
_output_shapes
:
ž
f
training/Adam/Sqrt_5Sqrttraining/Adam/clip_by_value_5*
T0* 
_output_shapes
:
ž
[
training/Adam/add_15/yConst*
valueB
 *żÖ3*
dtype0*
_output_shapes
: 
t
training/Adam/add_15Addtraining/Adam/Sqrt_5training/Adam/add_15/y*
T0* 
_output_shapes
:
ž
y
training/Adam/truediv_5RealDivtraining/Adam/mul_25training/Adam/add_15* 
_output_shapes
:
ž*
T0
p
training/Adam/ReadVariableOp_38ReadVariableOpdense_2/kernel*
dtype0* 
_output_shapes
:
ž

training/Adam/sub_16Subtraining/Adam/ReadVariableOp_38training/Adam/truediv_5*
T0* 
_output_shapes
:
ž
r
!training/Adam/AssignVariableOp_12AssignVariableOptraining/Adam/Variable_4training/Adam/add_13*
dtype0

training/Adam/ReadVariableOp_39ReadVariableOptraining/Adam/Variable_4"^training/Adam/AssignVariableOp_12*
dtype0* 
_output_shapes
:
ž
s
!training/Adam/AssignVariableOp_13AssignVariableOptraining/Adam/Variable_10training/Adam/add_14*
dtype0

training/Adam/ReadVariableOp_40ReadVariableOptraining/Adam/Variable_10"^training/Adam/AssignVariableOp_13*
dtype0* 
_output_shapes
:
ž
h
!training/Adam/AssignVariableOp_14AssignVariableOpdense_2/kerneltraining/Adam/sub_16*
dtype0

training/Adam/ReadVariableOp_41ReadVariableOpdense_2/kernel"^training/Adam/AssignVariableOp_14*
dtype0* 
_output_shapes
:
ž
c
training/Adam/ReadVariableOp_42ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
y
#training/Adam/mul_26/ReadVariableOpReadVariableOptraining/Adam/Variable_5*
dtype0*
_output_shapes	
:ž

training/Adam/mul_26Multraining/Adam/ReadVariableOp_42#training/Adam/mul_26/ReadVariableOp*
T0*
_output_shapes	
:ž
c
training/Adam/ReadVariableOp_43ReadVariableOpAdam/beta_1*
dtype0*
_output_shapes
: 
[
training/Adam/sub_17/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
u
training/Adam/sub_17Subtraining/Adam/sub_17/xtraining/Adam/ReadVariableOp_43*
T0*
_output_shapes
: 

training/Adam/mul_27Multraining/Adam/sub_178training/Adam/gradients/dense_2/BiasAdd_grad/BiasAddGrad*
_output_shapes	
:ž*
T0
m
training/Adam/add_16Addtraining/Adam/mul_26training/Adam/mul_27*
_output_shapes	
:ž*
T0
c
training/Adam/ReadVariableOp_44ReadVariableOpAdam/beta_2*
dtype0*
_output_shapes
: 
z
#training/Adam/mul_28/ReadVariableOpReadVariableOptraining/Adam/Variable_11*
dtype0*
_output_shapes	
:ž

training/Adam/mul_28Multraining/Adam/ReadVariableOp_44#training/Adam/mul_28/ReadVariableOp*
_output_shapes	
:ž*
T0
c
training/Adam/ReadVariableOp_45ReadVariableOpAdam/beta_2*
dtype0*
_output_shapes
: 
[
training/Adam/sub_18/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
u
training/Adam/sub_18Subtraining/Adam/sub_18/xtraining/Adam/ReadVariableOp_45*
T0*
_output_shapes
: 

training/Adam/Square_5Square8training/Adam/gradients/dense_2/BiasAdd_grad/BiasAddGrad*
_output_shapes	
:ž*
T0
o
training/Adam/mul_29Multraining/Adam/sub_18training/Adam/Square_5*
T0*
_output_shapes	
:ž
m
training/Adam/add_17Addtraining/Adam/mul_28training/Adam/mul_29*
T0*
_output_shapes	
:ž
j
training/Adam/mul_30Multraining/Adam/multraining/Adam/add_16*
T0*
_output_shapes	
:ž
[
training/Adam/Const_13Const*
_output_shapes
: *
valueB
 *    *
dtype0
[
training/Adam/Const_14Const*
_output_shapes
: *
valueB
 *  *
dtype0

%training/Adam/clip_by_value_6/MinimumMinimumtraining/Adam/add_17training/Adam/Const_14*
T0*
_output_shapes	
:ž

training/Adam/clip_by_value_6Maximum%training/Adam/clip_by_value_6/Minimumtraining/Adam/Const_13*
_output_shapes	
:ž*
T0
a
training/Adam/Sqrt_6Sqrttraining/Adam/clip_by_value_6*
T0*
_output_shapes	
:ž
[
training/Adam/add_18/yConst*
valueB
 *żÖ3*
dtype0*
_output_shapes
: 
o
training/Adam/add_18Addtraining/Adam/Sqrt_6training/Adam/add_18/y*
T0*
_output_shapes	
:ž
t
training/Adam/truediv_6RealDivtraining/Adam/mul_30training/Adam/add_18*
_output_shapes	
:ž*
T0
i
training/Adam/ReadVariableOp_46ReadVariableOpdense_2/bias*
dtype0*
_output_shapes	
:ž
{
training/Adam/sub_19Subtraining/Adam/ReadVariableOp_46training/Adam/truediv_6*
T0*
_output_shapes	
:ž
r
!training/Adam/AssignVariableOp_15AssignVariableOptraining/Adam/Variable_5training/Adam/add_16*
dtype0

training/Adam/ReadVariableOp_47ReadVariableOptraining/Adam/Variable_5"^training/Adam/AssignVariableOp_15*
dtype0*
_output_shapes	
:ž
s
!training/Adam/AssignVariableOp_16AssignVariableOptraining/Adam/Variable_11training/Adam/add_17*
dtype0

training/Adam/ReadVariableOp_48ReadVariableOptraining/Adam/Variable_11"^training/Adam/AssignVariableOp_16*
dtype0*
_output_shapes	
:ž
f
!training/Adam/AssignVariableOp_17AssignVariableOpdense_2/biastraining/Adam/sub_19*
dtype0

training/Adam/ReadVariableOp_49ReadVariableOpdense_2/bias"^training/Adam/AssignVariableOp_17*
_output_shapes	
:ž*
dtype0
š
training/group_depsNoOp	^loss/mul^metrics/acc/Mean^training/Adam/ReadVariableOp ^training/Adam/ReadVariableOp_15 ^training/Adam/ReadVariableOp_16 ^training/Adam/ReadVariableOp_17 ^training/Adam/ReadVariableOp_23 ^training/Adam/ReadVariableOp_24 ^training/Adam/ReadVariableOp_25 ^training/Adam/ReadVariableOp_31 ^training/Adam/ReadVariableOp_32 ^training/Adam/ReadVariableOp_33 ^training/Adam/ReadVariableOp_39 ^training/Adam/ReadVariableOp_40 ^training/Adam/ReadVariableOp_41 ^training/Adam/ReadVariableOp_47 ^training/Adam/ReadVariableOp_48 ^training/Adam/ReadVariableOp_49^training/Adam/ReadVariableOp_7^training/Adam/ReadVariableOp_8^training/Adam/ReadVariableOp_9
0

group_depsNoOp	^loss/mul^metrics/acc/Mean
I
VarIsInitializedOpVarIsInitializedOpAdam/lr*
_output_shapes
: 
\
VarIsInitializedOp_1VarIsInitializedOptraining/Adam/Variable_5*
_output_shapes
: 
]
VarIsInitializedOp_2VarIsInitializedOptraining/Adam/Variable_16*
_output_shapes
: 
S
VarIsInitializedOp_3VarIsInitializedOpAdam/iterations*
_output_shapes
: 
N
VarIsInitializedOp_4VarIsInitializedOp
Adam/decay*
_output_shapes
: 
\
VarIsInitializedOp_5VarIsInitializedOptraining/Adam/Variable_1*
_output_shapes
: 
O
VarIsInitializedOp_6VarIsInitializedOpAdam/beta_2*
_output_shapes
: 
\
VarIsInitializedOp_7VarIsInitializedOptraining/Adam/Variable_7*
_output_shapes
: 
\
VarIsInitializedOp_8VarIsInitializedOptraining/Adam/Variable_2*
_output_shapes
: 
P
VarIsInitializedOp_9VarIsInitializedOpdense/kernel*
_output_shapes
: 
]
VarIsInitializedOp_10VarIsInitializedOptraining/Adam/Variable_3*
_output_shapes
: 
O
VarIsInitializedOp_11VarIsInitializedOp
dense/bias*
_output_shapes
: 
^
VarIsInitializedOp_12VarIsInitializedOptraining/Adam/Variable_15*
_output_shapes
: 
^
VarIsInitializedOp_13VarIsInitializedOptraining/Adam/Variable_14*
_output_shapes
: 
^
VarIsInitializedOp_14VarIsInitializedOptraining/Adam/Variable_11*
_output_shapes
: 
^
VarIsInitializedOp_15VarIsInitializedOptraining/Adam/Variable_17*
_output_shapes
: 
]
VarIsInitializedOp_16VarIsInitializedOptraining/Adam/Variable_8*
_output_shapes
: 
[
VarIsInitializedOp_17VarIsInitializedOptraining/Adam/Variable*
_output_shapes
: 
S
VarIsInitializedOp_18VarIsInitializedOpdense_1/kernel*
_output_shapes
: 
Q
VarIsInitializedOp_19VarIsInitializedOpdense_2/bias*
_output_shapes
: 
]
VarIsInitializedOp_20VarIsInitializedOptraining/Adam/Variable_4*
_output_shapes
: 
]
VarIsInitializedOp_21VarIsInitializedOptraining/Adam/Variable_9*
_output_shapes
: 
Q
VarIsInitializedOp_22VarIsInitializedOpdense_1/bias*
_output_shapes
: 
^
VarIsInitializedOp_23VarIsInitializedOptraining/Adam/Variable_10*
_output_shapes
: 
^
VarIsInitializedOp_24VarIsInitializedOptraining/Adam/Variable_12*
_output_shapes
: 
^
VarIsInitializedOp_25VarIsInitializedOptraining/Adam/Variable_13*
_output_shapes
: 
S
VarIsInitializedOp_26VarIsInitializedOpdense_2/kernel*
_output_shapes
: 
]
VarIsInitializedOp_27VarIsInitializedOptraining/Adam/Variable_6*
_output_shapes
: 
P
VarIsInitializedOp_28VarIsInitializedOpAdam/beta_1*
_output_shapes
: 
ä
initNoOp^Adam/beta_1/Assign^Adam/beta_2/Assign^Adam/decay/Assign^Adam/iterations/Assign^Adam/lr/Assign^dense/bias/Assign^dense/kernel/Assign^dense_1/bias/Assign^dense_1/kernel/Assign^dense_2/bias/Assign^dense_2/kernel/Assign^training/Adam/Variable/Assign ^training/Adam/Variable_1/Assign!^training/Adam/Variable_10/Assign!^training/Adam/Variable_11/Assign!^training/Adam/Variable_12/Assign!^training/Adam/Variable_13/Assign!^training/Adam/Variable_14/Assign!^training/Adam/Variable_15/Assign!^training/Adam/Variable_16/Assign!^training/Adam/Variable_17/Assign ^training/Adam/Variable_2/Assign ^training/Adam/Variable_3/Assign ^training/Adam/Variable_4/Assign ^training/Adam/Variable_5/Assign ^training/Adam/Variable_6/Assign ^training/Adam/Variable_7/Assign ^training/Adam/Variable_8/Assign ^training/Adam/Variable_9/Assign
P

save/ConstConst*
_output_shapes
: *
valueB Bmodel*
dtype0

save/StringJoin/inputs_1Const*<
value3B1 B+_temp_67f7f2f694984f7a86e9bac4961188cc/part*
dtype0*
_output_shapes
: 
u
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
N*
_output_shapes
: *
	separator 
Q
save/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
k
save/ShardedFilename/shardConst"/device:CPU:0*
dtype0*
_output_shapes
: *
value	B : 

save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards"/device:CPU:0*
_output_shapes
: 
á
save/SaveV2/tensor_namesConst"/device:CPU:0*
valueűBřBAdam/beta_1BAdam/beta_2B
Adam/decayBAdam/iterationsBAdam/lrB
dense/biasBdense/kernelBdense_1/biasBdense_1/kernelBdense_2/biasBdense_2/kernelBtraining/Adam/VariableBtraining/Adam/Variable_1Btraining/Adam/Variable_10Btraining/Adam/Variable_11Btraining/Adam/Variable_12Btraining/Adam/Variable_13Btraining/Adam/Variable_14Btraining/Adam/Variable_15Btraining/Adam/Variable_16Btraining/Adam/Variable_17Btraining/Adam/Variable_2Btraining/Adam/Variable_3Btraining/Adam/Variable_4Btraining/Adam/Variable_5Btraining/Adam/Variable_6Btraining/Adam/Variable_7Btraining/Adam/Variable_8Btraining/Adam/Variable_9*
dtype0*
_output_shapes
:
Ź
save/SaveV2/shape_and_slicesConst"/device:CPU:0*M
valueDBBB B B B B B B B B B B B B B B B B B B B B B B B B B B B B *
dtype0*
_output_shapes
:
Ó

save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesAdam/beta_1/Read/ReadVariableOpAdam/beta_2/Read/ReadVariableOpAdam/decay/Read/ReadVariableOp#Adam/iterations/Read/ReadVariableOpAdam/lr/Read/ReadVariableOpdense/bias/Read/ReadVariableOp dense/kernel/Read/ReadVariableOp dense_1/bias/Read/ReadVariableOp"dense_1/kernel/Read/ReadVariableOp dense_2/bias/Read/ReadVariableOp"dense_2/kernel/Read/ReadVariableOp*training/Adam/Variable/Read/ReadVariableOp,training/Adam/Variable_1/Read/ReadVariableOp-training/Adam/Variable_10/Read/ReadVariableOp-training/Adam/Variable_11/Read/ReadVariableOp-training/Adam/Variable_12/Read/ReadVariableOp-training/Adam/Variable_13/Read/ReadVariableOp-training/Adam/Variable_14/Read/ReadVariableOp-training/Adam/Variable_15/Read/ReadVariableOp-training/Adam/Variable_16/Read/ReadVariableOp-training/Adam/Variable_17/Read/ReadVariableOp,training/Adam/Variable_2/Read/ReadVariableOp,training/Adam/Variable_3/Read/ReadVariableOp,training/Adam/Variable_4/Read/ReadVariableOp,training/Adam/Variable_5/Read/ReadVariableOp,training/Adam/Variable_6/Read/ReadVariableOp,training/Adam/Variable_7/Read/ReadVariableOp,training/Adam/Variable_8/Read/ReadVariableOp,training/Adam/Variable_9/Read/ReadVariableOp"/device:CPU:0*+
dtypes!
2	
 
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2"/device:CPU:0*'
_class
loc:@save/ShardedFilename*
_output_shapes
: *
T0
Ź
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency"/device:CPU:0*
N*
_output_shapes
:*
T0*

axis 

save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const"/device:CPU:0*
delete_old_dirs(

save/IdentityIdentity
save/Const^save/MergeV2Checkpoints^save/control_dependency"/device:CPU:0*
_output_shapes
: *
T0
ä
save/RestoreV2/tensor_namesConst"/device:CPU:0*
valueűBřBAdam/beta_1BAdam/beta_2B
Adam/decayBAdam/iterationsBAdam/lrB
dense/biasBdense/kernelBdense_1/biasBdense_1/kernelBdense_2/biasBdense_2/kernelBtraining/Adam/VariableBtraining/Adam/Variable_1Btraining/Adam/Variable_10Btraining/Adam/Variable_11Btraining/Adam/Variable_12Btraining/Adam/Variable_13Btraining/Adam/Variable_14Btraining/Adam/Variable_15Btraining/Adam/Variable_16Btraining/Adam/Variable_17Btraining/Adam/Variable_2Btraining/Adam/Variable_3Btraining/Adam/Variable_4Btraining/Adam/Variable_5Btraining/Adam/Variable_6Btraining/Adam/Variable_7Btraining/Adam/Variable_8Btraining/Adam/Variable_9*
dtype0*
_output_shapes
:
Ż
save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
dtype0*
_output_shapes
:*M
valueDBBB B B B B B B B B B B B B B B B B B B B B B B B B B B B B 
Ź
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*
_output_shapesv
t:::::::::::::::::::::::::::::*+
dtypes!
2	
N
save/Identity_1Identitysave/RestoreV2*
T0*
_output_shapes
:
T
save/AssignVariableOpAssignVariableOpAdam/beta_1save/Identity_1*
dtype0
P
save/Identity_2Identitysave/RestoreV2:1*
_output_shapes
:*
T0
V
save/AssignVariableOp_1AssignVariableOpAdam/beta_2save/Identity_2*
dtype0
P
save/Identity_3Identitysave/RestoreV2:2*
T0*
_output_shapes
:
U
save/AssignVariableOp_2AssignVariableOp
Adam/decaysave/Identity_3*
dtype0
P
save/Identity_4Identitysave/RestoreV2:3*
T0	*
_output_shapes
:
Z
save/AssignVariableOp_3AssignVariableOpAdam/iterationssave/Identity_4*
dtype0	
P
save/Identity_5Identitysave/RestoreV2:4*
T0*
_output_shapes
:
R
save/AssignVariableOp_4AssignVariableOpAdam/lrsave/Identity_5*
dtype0
P
save/Identity_6Identitysave/RestoreV2:5*
T0*
_output_shapes
:
U
save/AssignVariableOp_5AssignVariableOp
dense/biassave/Identity_6*
dtype0
P
save/Identity_7Identitysave/RestoreV2:6*
_output_shapes
:*
T0
W
save/AssignVariableOp_6AssignVariableOpdense/kernelsave/Identity_7*
dtype0
P
save/Identity_8Identitysave/RestoreV2:7*
_output_shapes
:*
T0
W
save/AssignVariableOp_7AssignVariableOpdense_1/biassave/Identity_8*
dtype0
P
save/Identity_9Identitysave/RestoreV2:8*
T0*
_output_shapes
:
Y
save/AssignVariableOp_8AssignVariableOpdense_1/kernelsave/Identity_9*
dtype0
Q
save/Identity_10Identitysave/RestoreV2:9*
T0*
_output_shapes
:
X
save/AssignVariableOp_9AssignVariableOpdense_2/biassave/Identity_10*
dtype0
R
save/Identity_11Identitysave/RestoreV2:10*
T0*
_output_shapes
:
[
save/AssignVariableOp_10AssignVariableOpdense_2/kernelsave/Identity_11*
dtype0
R
save/Identity_12Identitysave/RestoreV2:11*
_output_shapes
:*
T0
c
save/AssignVariableOp_11AssignVariableOptraining/Adam/Variablesave/Identity_12*
dtype0
R
save/Identity_13Identitysave/RestoreV2:12*
T0*
_output_shapes
:
e
save/AssignVariableOp_12AssignVariableOptraining/Adam/Variable_1save/Identity_13*
dtype0
R
save/Identity_14Identitysave/RestoreV2:13*
T0*
_output_shapes
:
f
save/AssignVariableOp_13AssignVariableOptraining/Adam/Variable_10save/Identity_14*
dtype0
R
save/Identity_15Identitysave/RestoreV2:14*
_output_shapes
:*
T0
f
save/AssignVariableOp_14AssignVariableOptraining/Adam/Variable_11save/Identity_15*
dtype0
R
save/Identity_16Identitysave/RestoreV2:15*
_output_shapes
:*
T0
f
save/AssignVariableOp_15AssignVariableOptraining/Adam/Variable_12save/Identity_16*
dtype0
R
save/Identity_17Identitysave/RestoreV2:16*
T0*
_output_shapes
:
f
save/AssignVariableOp_16AssignVariableOptraining/Adam/Variable_13save/Identity_17*
dtype0
R
save/Identity_18Identitysave/RestoreV2:17*
T0*
_output_shapes
:
f
save/AssignVariableOp_17AssignVariableOptraining/Adam/Variable_14save/Identity_18*
dtype0
R
save/Identity_19Identitysave/RestoreV2:18*
T0*
_output_shapes
:
f
save/AssignVariableOp_18AssignVariableOptraining/Adam/Variable_15save/Identity_19*
dtype0
R
save/Identity_20Identitysave/RestoreV2:19*
T0*
_output_shapes
:
f
save/AssignVariableOp_19AssignVariableOptraining/Adam/Variable_16save/Identity_20*
dtype0
R
save/Identity_21Identitysave/RestoreV2:20*
_output_shapes
:*
T0
f
save/AssignVariableOp_20AssignVariableOptraining/Adam/Variable_17save/Identity_21*
dtype0
R
save/Identity_22Identitysave/RestoreV2:21*
T0*
_output_shapes
:
e
save/AssignVariableOp_21AssignVariableOptraining/Adam/Variable_2save/Identity_22*
dtype0
R
save/Identity_23Identitysave/RestoreV2:22*
_output_shapes
:*
T0
e
save/AssignVariableOp_22AssignVariableOptraining/Adam/Variable_3save/Identity_23*
dtype0
R
save/Identity_24Identitysave/RestoreV2:23*
_output_shapes
:*
T0
e
save/AssignVariableOp_23AssignVariableOptraining/Adam/Variable_4save/Identity_24*
dtype0
R
save/Identity_25Identitysave/RestoreV2:24*
_output_shapes
:*
T0
e
save/AssignVariableOp_24AssignVariableOptraining/Adam/Variable_5save/Identity_25*
dtype0
R
save/Identity_26Identitysave/RestoreV2:25*
_output_shapes
:*
T0
e
save/AssignVariableOp_25AssignVariableOptraining/Adam/Variable_6save/Identity_26*
dtype0
R
save/Identity_27Identitysave/RestoreV2:26*
_output_shapes
:*
T0
e
save/AssignVariableOp_26AssignVariableOptraining/Adam/Variable_7save/Identity_27*
dtype0
R
save/Identity_28Identitysave/RestoreV2:27*
_output_shapes
:*
T0
e
save/AssignVariableOp_27AssignVariableOptraining/Adam/Variable_8save/Identity_28*
dtype0
R
save/Identity_29Identitysave/RestoreV2:28*
_output_shapes
:*
T0
e
save/AssignVariableOp_28AssignVariableOptraining/Adam/Variable_9save/Identity_29*
dtype0

save/restore_shardNoOp^save/AssignVariableOp^save/AssignVariableOp_1^save/AssignVariableOp_10^save/AssignVariableOp_11^save/AssignVariableOp_12^save/AssignVariableOp_13^save/AssignVariableOp_14^save/AssignVariableOp_15^save/AssignVariableOp_16^save/AssignVariableOp_17^save/AssignVariableOp_18^save/AssignVariableOp_19^save/AssignVariableOp_2^save/AssignVariableOp_20^save/AssignVariableOp_21^save/AssignVariableOp_22^save/AssignVariableOp_23^save/AssignVariableOp_24^save/AssignVariableOp_25^save/AssignVariableOp_26^save/AssignVariableOp_27^save/AssignVariableOp_28^save/AssignVariableOp_3^save/AssignVariableOp_4^save/AssignVariableOp_5^save/AssignVariableOp_6^save/AssignVariableOp_7^save/AssignVariableOp_8^save/AssignVariableOp_9
-
save/restore_allNoOp^save/restore_shard"<
save/Const:0save/Identity:0save/restore_all (5 @F8"¨
	variables
z
dense/kernel:0dense/kernel/Assign"dense/kernel/Read/ReadVariableOp:0(2+dense/kernel/Initializer/truncated_normal:08
g
dense/bias:0dense/bias/Assign dense/bias/Read/ReadVariableOp:0(2dense/bias/Initializer/zeros:08

dense_1/kernel:0dense_1/kernel/Assign$dense_1/kernel/Read/ReadVariableOp:0(2-dense_1/kernel/Initializer/truncated_normal:08
o
dense_1/bias:0dense_1/bias/Assign"dense_1/bias/Read/ReadVariableOp:0(2 dense_1/bias/Initializer/zeros:08

dense_2/kernel:0dense_2/kernel/Assign$dense_2/kernel/Read/ReadVariableOp:0(2+dense_2/kernel/Initializer/random_uniform:08
o
dense_2/bias:0dense_2/bias/Assign"dense_2/bias/Read/ReadVariableOp:0(2 dense_2/bias/Initializer/zeros:08

Adam/iterations:0Adam/iterations/Assign%Adam/iterations/Read/ReadVariableOp:0(2+Adam/iterations/Initializer/initial_value:08
c
	Adam/lr:0Adam/lr/AssignAdam/lr/Read/ReadVariableOp:0(2#Adam/lr/Initializer/initial_value:08
s
Adam/beta_1:0Adam/beta_1/Assign!Adam/beta_1/Read/ReadVariableOp:0(2'Adam/beta_1/Initializer/initial_value:08
s
Adam/beta_2:0Adam/beta_2/Assign!Adam/beta_2/Read/ReadVariableOp:0(2'Adam/beta_2/Initializer/initial_value:08
o
Adam/decay:0Adam/decay/Assign Adam/decay/Read/ReadVariableOp:0(2&Adam/decay/Initializer/initial_value:08

training/Adam/Variable:0training/Adam/Variable/Assign,training/Adam/Variable/Read/ReadVariableOp:0(2training/Adam/zeros:08

training/Adam/Variable_1:0training/Adam/Variable_1/Assign.training/Adam/Variable_1/Read/ReadVariableOp:0(2training/Adam/zeros_1:08

training/Adam/Variable_2:0training/Adam/Variable_2/Assign.training/Adam/Variable_2/Read/ReadVariableOp:0(2training/Adam/zeros_2:08

training/Adam/Variable_3:0training/Adam/Variable_3/Assign.training/Adam/Variable_3/Read/ReadVariableOp:0(2training/Adam/zeros_3:08

training/Adam/Variable_4:0training/Adam/Variable_4/Assign.training/Adam/Variable_4/Read/ReadVariableOp:0(2training/Adam/zeros_4:08

training/Adam/Variable_5:0training/Adam/Variable_5/Assign.training/Adam/Variable_5/Read/ReadVariableOp:0(2training/Adam/zeros_5:08

training/Adam/Variable_6:0training/Adam/Variable_6/Assign.training/Adam/Variable_6/Read/ReadVariableOp:0(2training/Adam/zeros_6:08

training/Adam/Variable_7:0training/Adam/Variable_7/Assign.training/Adam/Variable_7/Read/ReadVariableOp:0(2training/Adam/zeros_7:08

training/Adam/Variable_8:0training/Adam/Variable_8/Assign.training/Adam/Variable_8/Read/ReadVariableOp:0(2training/Adam/zeros_8:08

training/Adam/Variable_9:0training/Adam/Variable_9/Assign.training/Adam/Variable_9/Read/ReadVariableOp:0(2training/Adam/zeros_9:08

training/Adam/Variable_10:0 training/Adam/Variable_10/Assign/training/Adam/Variable_10/Read/ReadVariableOp:0(2training/Adam/zeros_10:08

training/Adam/Variable_11:0 training/Adam/Variable_11/Assign/training/Adam/Variable_11/Read/ReadVariableOp:0(2training/Adam/zeros_11:08

training/Adam/Variable_12:0 training/Adam/Variable_12/Assign/training/Adam/Variable_12/Read/ReadVariableOp:0(2training/Adam/zeros_12:08

training/Adam/Variable_13:0 training/Adam/Variable_13/Assign/training/Adam/Variable_13/Read/ReadVariableOp:0(2training/Adam/zeros_13:08

training/Adam/Variable_14:0 training/Adam/Variable_14/Assign/training/Adam/Variable_14/Read/ReadVariableOp:0(2training/Adam/zeros_14:08

training/Adam/Variable_15:0 training/Adam/Variable_15/Assign/training/Adam/Variable_15/Read/ReadVariableOp:0(2training/Adam/zeros_15:08

training/Adam/Variable_16:0 training/Adam/Variable_16/Assign/training/Adam/Variable_16/Read/ReadVariableOp:0(2training/Adam/zeros_16:08

training/Adam/Variable_17:0 training/Adam/Variable_17/Assign/training/Adam/Variable_17/Read/ReadVariableOp:0(2training/Adam/zeros_17:08"˛
trainable_variables
z
dense/kernel:0dense/kernel/Assign"dense/kernel/Read/ReadVariableOp:0(2+dense/kernel/Initializer/truncated_normal:08
g
dense/bias:0dense/bias/Assign dense/bias/Read/ReadVariableOp:0(2dense/bias/Initializer/zeros:08

dense_1/kernel:0dense_1/kernel/Assign$dense_1/kernel/Read/ReadVariableOp:0(2-dense_1/kernel/Initializer/truncated_normal:08
o
dense_1/bias:0dense_1/bias/Assign"dense_1/bias/Read/ReadVariableOp:0(2 dense_1/bias/Initializer/zeros:08

dense_2/kernel:0dense_2/kernel/Assign$dense_2/kernel/Read/ReadVariableOp:0(2+dense_2/kernel/Initializer/random_uniform:08
o
dense_2/bias:0dense_2/bias/Assign"dense_2/bias/Read/ReadVariableOp:0(2 dense_2/bias/Initializer/zeros:08

Adam/iterations:0Adam/iterations/Assign%Adam/iterations/Read/ReadVariableOp:0(2+Adam/iterations/Initializer/initial_value:08
c
	Adam/lr:0Adam/lr/AssignAdam/lr/Read/ReadVariableOp:0(2#Adam/lr/Initializer/initial_value:08
s
Adam/beta_1:0Adam/beta_1/Assign!Adam/beta_1/Read/ReadVariableOp:0(2'Adam/beta_1/Initializer/initial_value:08
s
Adam/beta_2:0Adam/beta_2/Assign!Adam/beta_2/Read/ReadVariableOp:0(2'Adam/beta_2/Initializer/initial_value:08
o
Adam/decay:0Adam/decay/Assign Adam/decay/Read/ReadVariableOp:0(2&Adam/decay/Initializer/initial_value:08

training/Adam/Variable:0training/Adam/Variable/Assign,training/Adam/Variable/Read/ReadVariableOp:0(2training/Adam/zeros:08

training/Adam/Variable_1:0training/Adam/Variable_1/Assign.training/Adam/Variable_1/Read/ReadVariableOp:0(2training/Adam/zeros_1:08

training/Adam/Variable_2:0training/Adam/Variable_2/Assign.training/Adam/Variable_2/Read/ReadVariableOp:0(2training/Adam/zeros_2:08

training/Adam/Variable_3:0training/Adam/Variable_3/Assign.training/Adam/Variable_3/Read/ReadVariableOp:0(2training/Adam/zeros_3:08

training/Adam/Variable_4:0training/Adam/Variable_4/Assign.training/Adam/Variable_4/Read/ReadVariableOp:0(2training/Adam/zeros_4:08

training/Adam/Variable_5:0training/Adam/Variable_5/Assign.training/Adam/Variable_5/Read/ReadVariableOp:0(2training/Adam/zeros_5:08

training/Adam/Variable_6:0training/Adam/Variable_6/Assign.training/Adam/Variable_6/Read/ReadVariableOp:0(2training/Adam/zeros_6:08

training/Adam/Variable_7:0training/Adam/Variable_7/Assign.training/Adam/Variable_7/Read/ReadVariableOp:0(2training/Adam/zeros_7:08

training/Adam/Variable_8:0training/Adam/Variable_8/Assign.training/Adam/Variable_8/Read/ReadVariableOp:0(2training/Adam/zeros_8:08

training/Adam/Variable_9:0training/Adam/Variable_9/Assign.training/Adam/Variable_9/Read/ReadVariableOp:0(2training/Adam/zeros_9:08

training/Adam/Variable_10:0 training/Adam/Variable_10/Assign/training/Adam/Variable_10/Read/ReadVariableOp:0(2training/Adam/zeros_10:08

training/Adam/Variable_11:0 training/Adam/Variable_11/Assign/training/Adam/Variable_11/Read/ReadVariableOp:0(2training/Adam/zeros_11:08

training/Adam/Variable_12:0 training/Adam/Variable_12/Assign/training/Adam/Variable_12/Read/ReadVariableOp:0(2training/Adam/zeros_12:08

training/Adam/Variable_13:0 training/Adam/Variable_13/Assign/training/Adam/Variable_13/Read/ReadVariableOp:0(2training/Adam/zeros_13:08

training/Adam/Variable_14:0 training/Adam/Variable_14/Assign/training/Adam/Variable_14/Read/ReadVariableOp:0(2training/Adam/zeros_14:08

training/Adam/Variable_15:0 training/Adam/Variable_15/Assign/training/Adam/Variable_15/Read/ReadVariableOp:0(2training/Adam/zeros_15:08

training/Adam/Variable_16:0 training/Adam/Variable_16/Assign/training/Adam/Variable_16/Read/ReadVariableOp:0(2training/Adam/zeros_16:08

training/Adam/Variable_17:0 training/Adam/Variable_17/Assign/training/Adam/Variable_17/Read/ReadVariableOp:0(2training/Adam/zeros_17:08"}
cond_context}ý|

Vloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/cond_textVloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id:0Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/switch_t:0 *
Iloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalar:0
Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Switch_1:0
Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Switch_1:1
Vloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id:0
Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/switch_t:0¤
Iloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalar:0Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Switch_1:1°
Vloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id:0Vloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id:0
ŃZ
Xloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/cond_text_1Vloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id:0Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/switch_f:0*¤)
nloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Merge:0
nloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Merge:1
oloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Switch:0
oloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Switch:1
qloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Switch_1:0
qloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Switch_1:1
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/DenseToDenseSetOperation:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/DenseToDenseSetOperation:1
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/DenseToDenseSetOperation:2
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/Switch:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/dim:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/Switch:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/dim:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/concat/axis:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/concat:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/num_invalid_dims:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_like/Const:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_like/Shape:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_like:0
{loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/x:0
yloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims:0
|loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank/Switch:0
~loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank/Switch_1:0
uloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank:0
ploss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id:0
qloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_f:0
qloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_t:0
Vloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id:0
Wloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/switch_f:0
Kloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/rank:0
Lloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shape:0
Lloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/rank:0
Mloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shape:0°
Vloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id:0Vloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/pred_id:0Ü
Lloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shape:0loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/Switch:0Î
Lloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/rank:0~loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank/Switch_1:0Ë
Kloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/rank:0|loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank/Switch:0ß
Mloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shape:0loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/Switch:02¤$
Ą$
ploss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/cond_textploss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id:0qloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_t:0 *Ĺ!
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/DenseToDenseSetOperation:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/DenseToDenseSetOperation:1
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/DenseToDenseSetOperation:2
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/Switch:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/Switch_1:1
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/dim:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/Switch:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/Switch_1:1
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/dim:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/concat/axis:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/concat:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/num_invalid_dims:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_like/Const:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_like/Shape:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ones_like:0
{loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/x:0
yloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims:0
ploss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id:0
qloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_t:0
Lloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shape:0
Mloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shape:0
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/Switch:0loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/Switch:0Ţ
Lloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shape:0loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims/Switch_1:1 
loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/Switch:0loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/Switch:0á
Mloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shape:0loss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/has_invalid_dims/ExpandDims_1/Switch_1:1ä
ploss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id:0ploss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id:02ő

ň

rloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/cond_text_1ploss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id:0qloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_f:0*
qloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Switch_1:0
qloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Switch_1:1
uloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank:0
ploss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id:0
qloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/switch_f:0ä
ploss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id:0ploss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/pred_id:0ę
uloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/is_same_rank:0qloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/has_valid_nonscalar_shape/Switch_1:0
˝
Sloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/cond_textSloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id:0Tloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_t:0 *¸
^loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/control_dependency:0
Sloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id:0
Tloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_t:0Ş
Sloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id:0Sloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id:0
Í
Uloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/cond_text_1Sloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id:0Tloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_f:0*Č
Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch:0
[loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_1:0
[loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_2:0
[loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_3:0
Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_0:0
Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_1:0
Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_2:0
Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_4:0
Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_5:0
Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/data_7:0
`loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/control_dependency_1:0
Sloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id:0
Tloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/switch_f:0
Iloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalar:0
Tloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Merge:0
Lloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shape:0
Mloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shape:0Ź
Mloss/activation_2_loss/broadcast_weights/assert_broadcastable/weights/shape:0[loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_1:0Ş
Sloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id:0Sloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/pred_id:0¨
Iloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_scalar:0[loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_3:0Ť
Lloss/activation_2_loss/broadcast_weights/assert_broadcastable/values/shape:0[loss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch_2:0ą
Tloss/activation_2_loss/broadcast_weights/assert_broadcastable/is_valid_shape/Merge:0Yloss/activation_2_loss/broadcast_weights/assert_broadcastable/AssertGuard/Assert/Switch:0*
serving_default
/
input&
flatten_input:0˙˙˙˙˙˙˙˙˙8
scores.
activation_2/Softmax:0˙˙˙˙˙˙˙˙˙žtensorflow/serving/predict
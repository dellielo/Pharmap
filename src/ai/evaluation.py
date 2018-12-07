import numpy as np

def get_n_best_pred_for_one_item(probs, n, idx2label):
    results = {}
    best_n = np.argsort(probs)[-n:][::-1]
    for index, best_id in enumerate(best_n):
        results[index] = {'label_pred':idx2label[best_id], 'prob': probs[best_id]}
    return results

def get_n_best_pred_for_one_item_tensor(probs, n, idx2label):
    results = []
    best_n = np.argsort(probs)[-n:][::-1]
    for index, best_id in enumerate(best_n):
        results.append(idx2label[best_id]) #{'label_pred':idx2label[best_id], 'prob': probs[best_id]}
    return results


def top_n_accuracy(preds, truths, n):
    best_n = np.argsort(preds, axis=1)[:,-n:]
    ts = truths #np.argmax(truths, axis=1)
    successes = 0
    for i in range(ts.shape[0]):
      if ts[i] in best_n[i,:]:
        successes += 1
    return float(successes)/ts.shape[0]


def keep_n_results_close(preds, n=10, th_pred_min=0.5):
    preds_ok = np.zeros(preds.shape)
    best_n = np.argsort(preds, axis=1)[:,-n:]
    for i in range(preds.shape[0]):
        if preds[best_n[i,:]] > th_pred_min:
            preds_ok[i,:] = best_n[i,:]
        else: 
            preds_ok[i,:] = 0
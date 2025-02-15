from tensorflow.keras.models import load_model
from tensorflow.keras.layers import DepthwiseConv2D
from tensorflow.keras.utils import load_img, img_to_array
import numpy as np
from flask import Flask, request, jsonify

class CustomDepthwiseConv2D(DepthwiseConv2D):
    def __init__(self, *args, **kwargs):
        # Remove 'groups' if it exists
        kwargs.pop('groups', None)
        super(CustomDepthwiseConv2D, self).__init__(*args, **kwargs)

# Load the model using the custom layer
model = load_model('cake_model.h5', custom_objects={'DepthwiseConv2D': CustomDepthwiseConv2D})

class_names = ['kue_barongko', 'kue_dange', 'kue_lapis', 'kue_onde', 'kue_taripang']

app = Flask(__name__)

# Fungsi untuk memprediksi gambar
def predict_image(image_path):
    # Muat dan proses gambar
    img = load_img(image_path, target_size=(128, 128))
    img_array = img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)
    img_array /= 255.0

    # Lakukan prediksi
    predictions = model.predict(img_array)
    predicted_class = np.argmax(predictions, axis=1)
    confidence_score = np.max(predictions)
    
    confidence_score_result = f"{confidence_score * 100:.2f}"
    predicted_class_result = class_names[predicted_class[0]],

    # Tampilkan hasil
    # if predicted_class[0] == 0:
    print("Prediksi: Benar")
    return {
        'predicted' : True,
        'predicted_class' : ''.join(predicted_class_result),
        'confidence_score' : confidence_score_result
    }
    # else:
    #     print("Prediksi: Salah")
    #     return {
    #         'predicted' : False,
    #         'predicted_class' : '-',
    #         'confidence_score' : '-'
    #     }

    # # Tampilkan nama kelas

    # print("Nama kelas yang diprediksi:", class_names[predicted_class[0]])

    # # Tampilkan gambar
    # plt.imshow(img)
    # plt.axis('off')
    # plt.show()
    
# Contoh pemanggilan fungsi
@app.route('/', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify(error='No file part'), 400

    file = request.files['file']
    
    if file.filename == '':
        return jsonify(error='No selected file')

    if file:
        temp_path = 'temp.jpg'
        file.save(temp_path)
        result = predict_image(temp_path)
        return jsonify(result)

# Server health check
@app.route('/', methods=['GET'])
def servercheck():
    return {'server': True, 'hello': "world"}

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=8080)

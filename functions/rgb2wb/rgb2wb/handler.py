# NOTE: Below the required modules to work with PIL
# python module.
#
#from PIL import Image
#import io
#import sys
#import os
#
import numpy as np
import cv2
import sys

def handle(image_data):
    """handle a request to the function
    Args:
        req (str): request body
    """
    # image is a numpy array
    np_array = np.fromstring(image_data, np.uint8)
    image = cv2.imdecode(np_array, cv2.IMREAD_COLOR)
    gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    img_str = cv2.imencode('.jpg', gray_image)[1].tostring()

    return str(img_str)

# NOTE: The next piece of code is able to do the same objective
# (convert a JPG image from RGB to gray scale), however it uses PIL
# python module.
#
#    image = Image.open(io.BytesIO(image_data))
#    out = image.convert('L')
#    out = image.convert('1')
#    out.save('/tmp/out.jpg')
#    out_file = open("/tmp/out.jpg","r+")
#    content = out_file.read()
#    out_file.close()
#    os.remove("/tmp/out.jpg")
#
#    return str(content)

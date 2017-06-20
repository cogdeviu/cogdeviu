
from imutils import paths
import argparse
import cv2


def variance_of_laplacian(image):
    # Compute the Laplacian of the image and then return the focus measure,
    # which is simply the variance of the Laplacian
    return cv2.Laplacian(image, cv2.CV_64F).var()

# Construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--images", required=True, help="path to input directory of images")
ap.add_argument("-t", "--threshold", type=float, default=50.0,
                help="focus measures that fall below this value will be considered 'blurry'")
args = vars(ap.parse_args())

# Loop over the input images
for imagePath in paths.list_images(args["images"]):
    # Load the image, convert it to grayscale
    img = cv2.imread(imagePath)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    # Compute the focus measure of the image using the Variance of Laplacian method
    fm = variance_of_laplacian(gray)

    # If the focus measure is less than the supplied threshold, then the image should be considered "blurry"
    if fm < args["threshold"]:
        text = "Blurry"
    else:
        text = "Not Blurry"

    # Show the image
    cv2.putText(img, "{}: {:.2f}".format(text, fm), (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (255, 0, 0), 3)
    cv2.imshow("Image", img)
    key = cv2.waitKey(0)

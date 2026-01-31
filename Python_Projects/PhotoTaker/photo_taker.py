from PIL import Image, ImageGrab
import tkinter as tk
import numpy as np

root = tk.Tk()

screen_width = root.winfo_screenwidth()
screen_height = root.winfo_screenheight()
# print(screen_width,screen_height)
def rgb_to_hex(rgb):
    return '{:02x}{:02x}{:02x}'.format(*rgb)
def snipSelf():
    x1 = 661
    y1 = 503
    x2 = x1+53
    y2 = y1+53
    img = ImageGrab.grab(bbox=(x1,y1,x2,y2))
    img.save("new_image.png")
    return img
def snipUpwards():
    x1 = 645
    y1 = 500-69
    x2 = x1+52
    y2 = y1+52
    img = ImageGrab.grab(bbox=(x1,y1,x2,y2))
    img.save("new_image.png")
    return img


img = snipUpwards()


resizedImage = img.resize((26,26))
resizedImage.save("resized_image.png")
pixels = img.load()
width,height = img.size
# print(pixels[27,7])
testResized = Image.new(mode="RGB",size=(26,26))
testPixels = testResized.load()
pixelsInHex = np.zeros((26,26), dtype="object")
for i in range(26):
    for j in range(26):
        x,y = i,j
        y+=0.5
        testPixels[i,25-j] = pixels[x*2,y*2]
        color = rgb_to_hex(testPixels[i,25-j])
        newline=""
        if j==0:
            if i%6==3:
                newline = "\n\n"
        x1 = i
        x2 = 25-j
        pixelsInHex[i,j] = f'{newline}{x1},{x2}{color}'
testResized.save("test.png")

str_without_quotes = ';'.join([';'.join(list(row)) for row in pixelsInHex])

print (str_without_quotes)
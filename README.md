# test_lyve

A new Flutter project.

## Getting Started

Test lyve:
this app for assessment from the lyve company. it has three screens :
1- login screen 2- home screen 3- product's details screen

-login screen : it is a regular login screen with new style. 
-Home screen : it has some information
about the user like : firstname-lastname-profile image and there is list of products and search bar.
-product's details screen : it has information about the product like : name, price , new price if
there a discount , slider that has images of the product, rate and description about it.

in this project :
the app work online but if there any problem in the network "disconnect" the app will still working
with the information that loaded from api but if the user to load more info a snakbar will appear to
inform the user that he has to reconnect to a network.

about the code:
state management : Getx fetch and data from api : http save user data from login api :
SharedPreferences

note :
all the api that send with the assessments has methods but the "get product by id " Api i did not
use it in app because when i used the getx for get all products from the api i can pass the
information that i want so i saw it is not good idea to use more api that i do not need and in this
way the performance will be more efficient.

note 2 :
i used in this project device_preview flutter package to ensure that the application interfaces will be suitable for all dimensions of the devices.

# Rappi



Rappi-iOS-Test

Credenciales para acceder a TMDB: user: arodriguez1981 pass: 210781Games

La búsqueda funciona poniendo en On el Switch de la categoría. O sea si esta en On el Switch se busca en esa categoria.

    Las capas de la aplicación (por ejemplo capa de persistencia, vistas, red, negocio, etc) y qué clases pertenecen a cual.

R: La capa de persistencia esta compuesta por varias clases, se encuentran dentro del grupo Entities. cada una de estas clases representa un tipo de dato (Movie, Serie, CreatedBy, etc). Los objetos de cada uno de estos tipos de datos son almacenados en la aplicación utilizando Realm. Otro de los grupos es Network, dentro se encuentran dos archivos NetConnection que contiene una clase del mismo nombre y clases funcion que se encargan de hacer las peticiones. Quiero destacar aquí que al menos yo, no encontré endpoints en la version 4 de la API que me permitieran cargar las categorías solicitadas, es por eso que en este archivo, en la parte superior hay dos URLs diferrentes, una para la versión 3 del API y uno para la versión 4, esta última solo se utilizó para obtener los tokens haciendo uso de BEARER y de los headers correspondientes. El otro archivo, ResponseHandler es el encargado como indica su nombre de manejar las respuestas recibidas por cada petición. Dentro del grupo ViewControllers se encuentran las clases encargadas de manejar el negocio de la aplicación, cada ViewController se encuentra dentro de una carpeta y esta asociado a un ViewControllerScene dentro de los diferentes storyboard. El grupo Cells contiene la clase relacionada a las celdas de los CollectionView. 

    La responsabilidad de cada clase creada.

R: AccessViewController es la clase encargada de manejar las solicitudes de los dos tokens necesarios para acceder a TMDB, en cada una de las funciones que se solicita el token correspondiente se manejan los posibles status code y se muestra un snackbar si es que hay algún status bar que no se corresponda con la respuesta de OK.

CategoryViewController es la clase encargada de mostrar y realizar las búsquedas. Maneja las funcionalidades del ScrollView, los CollectionsView, el Buscador y los botones del Scene correspondiente, así como las peticiones para obtener los elementos de las diferentes categorías teniendo en cuenta que para el caso de que la aplicación este online las solicitudes se hacen de acuerdo al numero de página correspondiente

EpisodeDetailsViewController y MovieDetailsViewController son los encargados de mostrar un pequeño conjunto de los detalles de los capítulos o peliculas, sus Scenes correspondientes tienen diseños diferentes con el objetivo de demostrar que se maneja correctamente el Autolayout.

    En qué consiste el principio de responsabilidad única? Cuál es su propósito?

R: Este principio consiste en en que cada clase debe ser encargada de una única responsabilidad, tratando de evitar mezclar dentro de ella más de una capa de la arquitectura. El propósito es tener clases lo más especializadas posible lo que influye positivamente a la hora de diseñar las pruebas, así como en la legibilidad y el manteniemiento del código.

    Qué características tiene, según su opinión, un “buen” código o código limpio.

El código debe estar indentado, las variables deben tener nombres descriptivos que permitan ser leidos y comprensibles, deben contar con un estilo de escritura correcto (CamelCase, lowerCamelcase, etc) , las funcionalidades deben estar agrupadas y ordenadas y lo mas simples posibles. Todo esto debe ir unido a los principios de SOLID.

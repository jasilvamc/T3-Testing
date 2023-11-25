## Tarea 4

### Logros de la entrega:
Juan Vergara: Tests de sistema y parte de los tests de navegación
José Antonio Silva: Mejora al sistema de reserva y parte de los tests de navegación

### Descripción de los tests nuevos:
Para testear el form de creación de producto, se testea un happy path y tres caminos alternativos, que fallan por los siguientes motivos:
- No se ingresa el nombre del producto
- El precio del producto no es un número
- El stock del producto no es un número
Para todos estos tests, primero se crea un usuario admin que pueda crear los productos. Luego se intenta crear (con diferentes resultados dependiendo de si es happy path o no) y se revisa que el mensaje de error (o confirmación) sea el correcto.

Para testear el form de registro de usuario, se testea un happy path y dos caminos alternativos, que fallan por los siguientes motivos:
- Se ingresa un correo que ya está registrado
- No se ingresa un correo
Para estos tests, se revisa que el mensaje de error (o confirmación) sea el correcto, y/o que la página se redirija correctamente.

Como tests de navegación, se tiene lo siguiente:
- Se navega hacia la vista de creación de producto con un usuario admin y se usa el boton cancelar, volviendo al landing page.
- Se navega hacia la vista de creación de producto con un usuario admin.
- Se navega hacia la vista de creación de producto con un usuario no admin, y se revisa que aparezca el mensaje de error correcto.
- Se navega desde el inicio hacia la vista de registro y luego se usa el boton para volver al inicio, revisando que se haya vuelto correctamente. Se hace lo mismo visitando las vistas de login y contacto en lugar de registro. También se hace lo mismo desde el inicio, usando directamente el boton que lleva al inicio.
- Se navega desde el inicio hacia la vista de users/show, usando el boton de inicio para volver al inicio.
- Se navega desde el inicio hacia la vista de users/show, usando el boton de editar para ir a la vista de edición de usuario.
- Se navega desde el inicio hacia la vista de edit, usando el boton de inicio para volver al inicio.

### Descripción de la mejora al sistema de reserva:
- Se cambió la forma en que e ingresa el horario de reserva, donde se debe indicar un día y horas de inicio y fin. Esto se hizo para que sea más fácil de entender para el usuario, y para que sea más fácil de implementar en el código. No permite agregar varios horarios, sino que se espera que se cree un producto nuevo (pensando que la existencia de stock y la definición de un horario es suficiente para un solo producto)
- Se valida a nivel de modelo que el formato de horario sea correcto, mostrando un mensaje de error si no lo es.
- Para reservar, se debe ingresar una fecha correcta y un horario que esté dentro del horario de reserva del producto. Si no se cumple alguna de estas condiciones, se muestra un mensaje de error, distinguiendo entre si la fecha es incorrecta o si el horario no está dentro del horario de reserva. Esto se hace dentro del controlador. 


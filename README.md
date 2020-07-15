BatleShip

Para correr el juego hacer:
yarn #para las dependencias
yarn start #se abrirá el localhost


En el juego:
Para setear los barcos haz click en el tipo de barco y luego haz click en la casilla que lo quieras hubicar
Luego haz click en jugar, si te arrepentiste de alguna decision haz click en "resetear".
Una vez iniciado el juego haz click en la accion que quieres realizar, luego el barco que quieres que realice esa accion y finalmente a la casilla dondee quieres que se mueva o dispare, en caso de que la casilla no sea valida, se mostrara un warning en la pantalla y deberas elegir otra casilla. Si quieres cambiar de accion antes de mover o disparar apreta cancelar.
Cada vez que juegues el computador hará una acción.
Cuando ganes o pierdas será notificado en la pantalla.



Consideraciones:

Al mandar los eventos a traves del body, no logra obtener respuesta de la api por lo que esa implementacion la deje comentada(por favor revisarla, linea 7 de App.js hay un booleano para habilitar mandar eventos).


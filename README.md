--- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.


```sql
SELECT  oficina_id, ciudad_id from oficina order by oficina_id;

```
--- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

```sql
SELECT  ciu.nombre AS nombre_ciudad, ofi.telefono from oficina AS ofi
INNER JOIN ciudad AS ciu ON ofi.ciudad_id = ciu.ciudad_id
INNER JOIN region AS reg ON ciu.region_id = reg.region_id
INNER JOIN pais AS pa ON reg.pais_id = pa.pais_id
WHERE pa.nombre = 'España';
```
--- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.


```sql
SELECT nombre, apellido1, apellido2, email FROM empleado
WHERE  codigo_jefe = 7;

```
--- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.

```sql
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado
WHERE codigo_jefe_id is NULL;

```
--- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.

```sql
SELECT nombre, apellido1, apellido2, puesto FROM empleado
WHERE puesto != 'representante de ventas';
```
--- 6. Devuelve un listado con el nombre de los todos los clientes españoles.

```sql
SELECT cli.nombre_cliente FROM cliente AS cli
INNER JOIN ciudad AS ciu ON cli.ciudad_id = ciu.ciudad_id
INNER JOIN region AS reg ON reg.region_id = ciu.region_id
INNER JOIN pais AS pa ON pa.pais_id = reg.pais_id
WHERE pa.nombre = 'España';
```
--- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.

```sql
SELECT nombre_estado FROM estado_pedido;
```
--- 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

```sql
SELECT DISTINCT cli.cliente_id, cli.nombre_cliente FROM cliente AS cli
INNER JOIN pago AS pa ON cli.cliente_id = pa.cliente_id
WHERE year(fecha_pago) = 2008;
```
--- Utilizando la función DATE_FORMAT de MySQL.

```sql
SELECT DISTINCT cli.cliente_id, cli.nombre_cliente FROM cliente AS cli
INNER JOIN pago AS pa ON cli.cliente_id = pa.cliente_id
WHERE DATE_FORMAT(fecha_pago_id, '%Y') = '2008';
```
--- Sin utilizar ninguna de las funciones anteriores.

```sql
SELECT DISTINCT cli.cliente_id, cli.nombre_cliente FROM cliente AS cli
INNER JOIN pago AS pa ON cli.cliente_id = pa.cliente_id
WHERE fecha_pago_id >= '2008-01-01' AND fecha_pago_id <= '2008-12-31';
```
--- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.

```sql
SELECT pedido_id, cliente_id, fecha_esperada, fecha_entregada
FROM pedido
WHERE fecha_entregada > fecha_esperada;
```
--- 10. Devuelve un listado con el código de pedido, código de cliente, fechaesperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

```sql
SELECT pedido_id, cliente_id, fecha_esperada, fecha_entregada 
FROM pedido                                                          
WHERE (fecha_esperada - fecha_entregada) >=  2;			 *  * * * * * * * **
```

--- Utilizando la función DATEDIFF de MySQL.
```sql
SELECT pedido_id, cliente_id, fecha_esperada, fecha_entregada 
FROM pedido
WHERE DATEDIFF(fecha_esperada, fecha_entregada) >= 2;
```
--- • Utilizando la función ADDDATE de MySQL.

```sql
SELECT pedido_id, cliente_id, fecha_esperada, fecha_entregada 
FROM pedido
WHERE fecha_entregada <= ADDDATE(fecha_esperada, -2);
```
--- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

```sql
SELECT ped.pedido_id 
FROM pedido AS ped
INNER JOIN estado_pedido AS esp
ON ped.estado_pedido_id = esp.estado_id
WHERE esp.nombre_estado = 'Rechazado'
AND estado_id IN
(SELECT pedi2.pedido_id FROM pedido AS pedi2
WHERE year(pedi2.fecha_pedido) = 2009);
```
--- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.

```sql
SELECT ped.pedido_id 
FROM pedido AS ped
INNER JOIN estado_pedido AS esp
ON ped.estado_pedido_id = esp.estado_id
WHERE esp.nombre_estado = 'Entregado'
AND estado_id IN
(SELECT pedi2.pedido_id FROM pedido AS pedi2
WHERE month(pedi2.fecha_pedido) = 01); **** EJEMPLO SUBCONSULTA


SELECT ped.pedido_id 
FROM pedido AS ped
INNER JOIN estado_pedido AS esp
ON ped.estado_pedido_id = esp.estado_id
WHERE esp.nombre_estado = 'Entregado'
AND month(ped.fecha_pedido) = 01;

```
--- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

```sql
SELECT pa.transaccion_id, fp.nombre_forma_pago
FROM pago AS pa
INNER JOIN forma_pago AS fp
ON pa.forma_pago_id = fp.forma_pago_id
WHERE fp.nombre_forma_pago = 'PayPal'
AND year(pa.fecha_pago) = 2008
ORDER BY pa.fecha_pago desc; 
```
--- 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.

```sql
SELECT DISTINCT fp.nombre_forma_pago
FROM pago AS pa 
INNER JOIN forma_pago AS fp
ON pa.forma_pago_id = fp.forma_pago_id;
```
--- 15. Devuelve un listado con todos los productos que pertenecen a la
--- gama Tablets y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.

```sql
SELECT pro.nombre, pro.gama_id, pro.precio_venta
FROM producto AS pro
WHERE pro.cantidad_en_stock > 100
AND pro.gama_id = 'Tablets'
ORDER BY pro.precio_venta desc;
```
--- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.

```sql
SELECT cli.nombre_cliente 
FROM cliente AS cli
INNER JOIN ciudad AS ciu
ON cli.ciudad_id = ciu.ciudad_id
WHERE ciu.nombre = 'Gerona'
AND cli.empleado_id = 30;
```
--- CONSULTAS MULTITABLA


--- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

```sql
SELECT cli.nombre_cliente AS Cliente, emp.nombre AS 'Nombre Vendedor', emp.apellido1 AS 'Apellido Vendedor'
FROM cliente AS cli
INNER JOIN empleado AS emp
ON cli.empleado_id = emp.empleado_id;
```
--- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

```sql
SELECT cli.nombre_cliente AS Cliente, emp.nombre AS 'Representante de ventas'
FROM cliente AS cli
INNER JOIN pago AS pag
ON cli.cliente_id = pag.cliente_id
INNER JOIN empleado AS emp
ON cli.empleado_id = emp.empleado_id;
```
--- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

```sql
SELECT cli.nombre_cliente AS 'Nombre de cliente', emp.nombre AS 'Nombre de Representante de ventas'
FROM cliente AS cli 
INNER JOIN empleado AS emp ON cli.empleado_id = emp.empleado_id
WHERE cli.cliente_id NOT IN (SELECT pa1.cliente_id FROM pago AS pa1);
```
--- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
```sql
SELECT cli.nombre_cliente AS 'Nombre de cliente', emp.nombre AS 'Nombre de Representante de ventas', ciu.nombre AS 'Ciudad de la oficina'
FROM cliente AS cli 
INNER JOIN empleado AS emp 
ON cli.empleado_id = emp.empleado_id
INNER JOIN oficina AS ofi
ON emp.codigo_oficina_id = ofi.oficina_id
INNER JOIN ciudad AS ciu
ON ofi.ciudad_id = ciu.ciudad_id
WHERE cli.cliente_id IN (SELECT pa1.cliente_id FROM pago AS pa1);
```
--- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

```sql
SELECT cli.nombre_cliente AS 'Nombre de cliente', emp.nombre AS 'Nombre de Representante de ventas', ciu.nombre AS 'Ciudad de la oficina'
FROM cliente AS cli 
INNER JOIN empleado AS emp 
ON cli.empleado_id = emp.empleado_id
INNER JOIN oficina AS ofi
ON emp.codigo_oficina_id = ofi.oficina_id
INNER JOIN ciudad AS ciu
ON ofi.ciudad_id = ciu.ciudad_id
WHERE cli.cliente_id NOT IN (SELECT pa1.cliente_id FROM pago AS pa1);
```
--- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

```sql
SELECT cli.nombre_cliente, ofi.linea_direccion1, ofi.linea_direccion2 
FROM oficina AS ofi
INNER JOIN empleado AS emp 
ON ofi.oficina_id = emp.codigo_oficina_id
INNER join cliente AS cli
ON cli.empleado_id = emp.empleado_id
INNER JOIN ciudad AS ciu
ON ciu.ciudad_id = cli.ciudad_id
WHERE ciu.nombre= 'Fuenlabrada';
```
--- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

```sql
SELECT cli.nombre_cliente AS 'Nombre de cliente', emp.nombre AS 'Nombre de Representante de ventas', ciu.nombre AS 'Ciudad de la oficina'
FROM cliente AS cli 
INNER JOIN empleado AS emp 
ON cli.empleado_id = emp.empleado_id
INNER JOIN oficina AS ofi
ON emp.codigo_oficina_id = ofi.oficina_id
INNER JOIN ciudad AS ciu
ON ofi.ciudad_id = ciu.ciudad_id;
```
--- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

```sql
SELECT emp.nombre AS nombre_empleado, emp.apellido1 AS apellido1_empleado, emp.apellido2 AS apellido2_empleado, jefe.nombre AS nombre_jefe, jefe.apellido1 AS apellido1_jefe, jefe.apellido2 AS apellido2_jefe
FROM empleado AS emp
LEFT JOIN empleado AS jefe ON emp.codigo_jefe_id = jefe.empleado_id;
```
--- 9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

```sql
SELECT emp.nombre AS 'Nombre empleado', emp.apellido1 AS 'Apellido empleado', jefe.nombre AS 'Nombre jefe directo', jefe.apellido1 AS 'Apellido jefe directo', jefe2.nombre AS 'Nombre jefe del jefe', jefe2.apellido1 AS 'Apellido jefe del jefe'
FROM empleado AS emp
LEFT JOIN empleado AS jefe 
ON emp.codigo_jefe_id = jefe.empleado_id
LEFT JOIN empleado AS jefe2
ON jefe.codigo_jefe_id = jefe2.empleado_id;
```
--- 10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

```sql
SELECT cli.nombre_cliente
FROM pedido AS ped
INNER JOIN cliente AS cli
ON ped.cliente_id = cli.cliente_id
WHERE ped.fecha_entregada > ped.fecha_esperada;
```
--- 11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

```sql
SELECT DISTINCT cli.nombre_cliente, gp.gama_id
FROM cliente AS cli
INNER JOIN pedido AS ped
ON cli.cliente_id = ped.cliente_id
INNER JOIN detalle_pedido AS det
ON ped.pedido_id = det.codigo_pedido
INNER JOIN producto AS pro
ON det.codigo_producto = pro.producto_id
INNER JOIN gama_producto AS gp
ON pro.gama_id = gp.gama_id;
```
--- Consultas multitabla (Composición externa)

```sql
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
LEFT JOIN y NATURAL RIGHT JOIN.
```
--- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

```sql
SELECT cli.nombre_cliente AS 'Nombre de cliente' FROM cliente AS cli
WHERE cli.cliente_id NOT IN (SELECT pa.cliente_id FROM pago AS pa);
```
--- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

```sql
INSERT INTO pedido (estado_pedido_id, fecha_pedido, fecha_esperada, fecha_entregada, comentarios, cliente_id)
VALUES (1, '2024-05-01', '2024-05-05', NULL, 'Urgente', NULL);
```
--- 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.

```sql
SELECT cli.nombre_cliente
FROM cliente AS cli
LEFT JOIN pago AS pa 
ON pa.cliente_id = cli.cliente_id
INNER JOIN pedido AS pe
ON cli.cliente_id = pe.cliente_id
WHERE pe.cliente_id IS NULL
AND pa.cliente_id IS NULL;
```
--- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

```sql
SELECT cli.nombre_cliente
FROM cliente AS cli
LEFT JOIN pago AS pa 
ON pa.cliente_id = cli.cliente_id
LEFT JOIN pedido AS pe
ON pe.cliente_id = cli.cliente_id
WHERE pe.pedido_id IS NULL
AND pa.transaccion_id IS NULL;
```
--- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

```sql
SELECT emp.empleado_id, emp.nombre, cli.nombre_cliente
FROM empleado AS emp
LEFT JOIN cliente AS cli
ON emp.empleado_id = cli.empleado_id
WHERE cli.empleado_id IS NULL;
```
--- 6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.

```sql
SELECT emp.nombre, cli.nombre_cliente, ofi.oficina_id
FROM empleado AS emp
LEFT JOIN cliente AS cli
ON emp.empleado_id = cli.empleado_id
INNER JOIN oficina AS ofi
ON emp.codigo_oficina_id = ofi.oficina_id
WHERE cli.empleado_id IS NULL;
```
--- 7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

```sql
ELECT emp.nombre, emp.apellido1, emp.apellido2 
FROM empleado AS emp
LEFT JOIN oficina AS ofi
ON emp.codigo_oficina_id = ofi.oficina_id
LEFT JOIN cliente AS cli
ON emp.empleado_id = cli.empleado_id
WHERE cli.empleado_id IS NULL AND emp.codigo_oficina_id IS NULL;
```
--- 8. Devuelve un listado de los productos que nunca han aparecido en un pedido.
--- OP1
```sql
SELECT pro.nombre
FROM producto AS pro
LEFT JOIN detalle_pedido AS det
ON pro.producto_id = det.codigo_producto
WHERE producto_id
NOT IN (SELECT det1.codigo_producto FROM detalle_pedido AS det1);
```
--- OP2

```sql
SELECT pro.nombre 
FROM producto AS pro
LEFT JOIN detalle_pedido AS dp
ON pro.producto_id = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;
```
--- 9. Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.


```sql
SELECT pro.nombre, pro.descripcion, gp.imagen
FROM producto AS pro
LEFT JOIN detalle_pedido AS det
ON pro.producto_id = det.codigo_producto
INNER JOIN gama_producto AS gp
ON pro.gama_id = gp.gama_id
WHERE producto_id
NOT IN (SELECT det1.codigo_producto FROM detalle_pedido AS det1);
```
--- 10. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Componentes.

```sql
SELECT ofi.oficina_id
FROM oficina AS ofi
LEFT JOIN empleado AS emp
ON ofi.oficina_id = emp.codigo_oficina_id
WHERE emp.empleado_id 
NOT IN (   SELECT DISTINCT emp2.empleado_id
    FROM empleado AS emp2
    INNER JOIN cliente AS cli
    ON emp2.empleado_id = cli.empleado_id
    INNER JOIN pedido AS ped
    ON cli.cliente_id = ped.cliente_id
    INNER JOIN detalle_pedido AS det
    ON ped.pedido_id = det.codigo_pedido
    INNER JOIN producto AS pro
    ON det.codigo_producto = pro.producto_id
    INNER JOIN gama_producto AS gp
    ON pro.gama_id = gp.gama_id
    WHERE gp.gama_id = 'Componentes' AND emp2.puesto = 'Representante de ventas') 
    AND emp.puesto != 'Representante de ventas';


```
--- 11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

```sql
SELECT cli.cliente_id, cli.nombre_cliente
FROM cliente AS cli
INNER JOIN pedido AS ped
ON cli.cliente_id = ped.cliente_id
LEFT JOIN pago AS pa
ON cli.cliente_id = pa.cliente_id
WHERE pa.cliente_id IS NULL;
```
--- 12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

```sql
SELECT emp.empleado_id, emp.nombre AS 'Nombre empleado', emp.codigo_jefe_id, jefe.nombre AS 'Nombre jefe', jefe.apellido1 AS 'Apellido jefe'
FROM empleado AS emp
LEFT JOIN cliente AS cli 
ON emp.empleado_id = cli.empleado_id
LEFT JOIN empleado AS jefe 
ON emp.codigo_jefe_id = jefe.empleado_id
WHERE cli.cliente_id IS NULL;
```
--- Consultas resumen
--- 1. ¿Cuántos empleados hay en la compañía?

```sql
SELECT COUNT(emp.empleado_id)  AS 'Cantidad Empleados'
FROM empleado AS emp;
```
--- 2. ¿Cuántos clientes tiene cada país?

```sql
SELECT pa.pais_id, COUNT(cli.cliente_id) AS 'CANTIDAD CLIENTES'
FROM cliente AS cli
INNER JOIN ciudad AS ciu 
ON cli.ciudad_id = ciu.ciudad_id
INNER JOIN region AS reg 
ON ciu.region_id = reg.region_id
INNER JOIN pais AS pa 
ON reg.pais_id = pa.pais_id
GROUP BY pa.pais_id;
```
--- 3. ¿Cuál fue el pago medio en 2009?

```sql
SELECT AVG(pag.total) AS 'pago medio'
FROM pago AS pag;
```
--- 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.


```sql
SELECT ep.nombre_estado, COUNT(ped.pedido_id) AS 'cantidad_pedidos'
FROM pedido AS ped
INNER JOIN estado_pedido AS ep
ON ep.estado_id = ped.estado_pedido_id
GROUP BY ep.nombre_estado;
```
--- 5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.

```sql
SELECT MAX(precio_venta), MIN(precio_venta)
FROM producto;
```
--- 6. Calcula el número de clientes que tiene la empresa.

```sql
SELECT COUNT(cliente_id) AS 'CANTIDAD CLIENTE'  FROM cliente;
```
--- 7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

```sql
SELECT COUNT(cliente_id) AS 'cantidad clientes' , ciu.nombre AS 'nombre ciudad'
FROM cliente AS cli
INNER JOIN ciudad AS ciu
ON cli.ciudad_id = ciu.ciudad_id
WHERE ciu.nombre = 'Bogotá';
```
--- 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?

```sql
SELECT ciu.nombre AS nombre_ciudad, COUNT(cli.cliente_id) AS cantidad_clientes
FROM cliente AS cli
INNER JOIN ciudad AS ciu ON cli.ciudad_id = ciu.ciudad_id
WHERE ciu.nombre LIKE 'M%'
GROUP BY ciu.nombre
ORDER BY cantidad_clientes DESC;
```
--- 9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.

```sql
SELECT emp.nombre AS 'Nombre Representante Ventas', COUNT(cli.cliente_id) AS 'Cantidad Clientes'
FROM empleado AS emp
INNER JOIN cliente AS cli
ON cli.empleado_id = emp.empleado_id
WHERE emp.puesto = 'Representante de Ventas'
GROUP BY emp.nombre;

```
--- 10. Calcula el número de clientes que no tiene asignado representante de ventas.

```sql
SELECT COUNT(cli.cliente_id) AS 'cantidad clientes'
FROM cliente AS cli
LEFT JOIN empleado AS emp
ON cli.empleado_id = emp.empleado_id
WHERE cli.empleado_id IS NULL;
```
--- 11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

```sql
SELECT cli.nombre_cliente , MIN(pa.fecha_pago_id) AS 'Primer Pago', MAX(pa.fecha_pago_id) AS 'Ultimo Pago'
FROM pago AS pa
INNER JOIN cliente AS cli
ON cli.cliente_id = pa.cliente_id
GROUP BY cli.cliente_id;

INSERT INTO pago(transaccion_id, cliente_id,forma_pago_id, fecha_pago_id, total)
VALUES ('TRX024', 1,1,'2009-01-01', 5000);
```
--- 12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.

```sql
SELECT pro.producto_id ,SUM(dp.cantindad)
FROM producto AS pro
INNER JOIN detalle_pedido AS dp
ON pro.producto_id = dp.codigo_producto
GROUP BY pro.producto_id;
```
--- 13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.

```sql
SELECT codigo_pedido, SUM(cantindad) AS 'Suma total productos'
FROM detalle_pedido AS det 
GROUP BY codigo_pedido;
```
--- 14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.

```sql
SELECT pro.nombre AS 'Nombre Producto', SUM(det.cantindad) AS 'Unidades vendidas'
FROM detalle_pedido AS det
INNER JOIN producto AS pro
ON pro.producto_id = det.codigo_producto
GROUP BY pro.nombre
ORDER BY SUM(det.cantindad) by desc
LIMIT 20;
```
--- 15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.

```sql
SELECT SUM(dp.cantindad * dp.precio_unidad) AS 'Base Imponible', (SUM(dp.cantindad * dp.precio_unidad) * 0.21) AS 'IVA 21%',  (SUM(dp.cantindad * dp.precio_unidad) * 1.21) AS 'Valor Total H'
FROM pago AS pa
INNER JOIN cliente AS cli
ON pa.cliente_id = cli.cliente_id
INNER JOIN pedido AS ped
ON cli.cliente_id = ped.cliente_id
INNER JOIN detalle_pedido AS dp
ON ped.pedido_id = dp.codigo_pedido
INNER JOIN producto AS pro
ON pro.producto_id = dp.codigo_producto
;
```
--- 16. La misma información que en la pregunta anterior, pero agrupada por código de producto.

```sql
SELECT dp.codigo_producto ,SUM(dp.cantindad * dp.precio_unidad) AS 'Base Imponible', (SUM(dp.cantindad * dp.precio_unidad) * 0.21) AS 'IVA 21%',  (SUM(dp.cantindad * dp.precio_unidad) * 1.21) AS 'Valor Total H'
FROM pago AS pa
INNER JOIN cliente AS cli
ON pa.cliente_id = cli.cliente_id
INNER JOIN pedido AS ped
ON cli.cliente_id = ped.cliente_id
INNER JOIN detalle_pedido AS dp
ON ped.pedido_id = dp.codigo_pedido
INNER JOIN producto AS pro
ON pro.producto_id = dp.codigo_producto
GROUP BY dp.codigo_producto
;

```
--- 17. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.

```sql
SELECT dp.codigo_producto ,SUM(dp.cantindad * dp.precio_unidad) AS 'Base Imponible', (SUM(dp.cantindad * dp.precio_unidad) * 0.21) AS 'IVA 21%',  (SUM(dp.cantindad * dp.precio_unidad) * 1.21) AS 'Valor Total H'
FROM pago AS pa
INNER JOIN cliente AS cli
ON pa.cliente_id = cli.cliente_id
INNER JOIN pedido AS ped
ON cli.cliente_id = ped.cliente_id
INNER JOIN detalle_pedido AS dp
ON ped.pedido_id = dp.codigo_pedido
INNER JOIN producto AS pro
ON pro.producto_id = dp.codigo_producto
WHERE pro.producto_id LIKE 'PROD1%'
GROUP BY dp.codigo_producto
;
```
--- 18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).

```sql
SELECT pro.nombre, SUM(dp.cantindad) AS 'Cantidad Vendida', SUM(dp.cantindad * dp.precio_unidad) AS 'Total Facturado', (SUM(dp.cantindad * dp.precio_unidad) * 1.21) AS 'Valor Total Facturado Con Impuestos'
FROM pago AS pa
INNER JOIN cliente AS cli ON pa.cliente_id = cli.cliente_id
INNER JOIN pedido AS ped ON cli.cliente_id = ped.cliente_id
INNER JOIN detalle_pedido AS dp ON ped.pedido_id = dp.codigo_pedido
INNER JOIN producto AS pro ON pro.producto_id = dp.codigo_producto
GROUP BY pro.nombre
HAVING SUM(dp.cantindad * dp.precio_unidad) > 2000;
```
--- 19. Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.

```sql
SELECT SUM(pa.total) AS 'Total Pago', year(pa.fecha_pago_id) AS 'AÑO'
FROM pago AS pa
GROUP BY year(pa.fecha_pago_id);

```
**** Subconsultas Con operadores básicos de comparación 

--- 1. Devuelve el nombre del cliente con mayor límite de crédito. 

```sql
SELECT nombre_cliente
FROM cliente
WHERE limite_credito = (
SELECT MAX(limite_credito)
FROM cliente
);

```
--- 2. Devuelve el nombre del producto que tenga el precio de venta más caro. 

```sql
SELECT nombre
FROM producto
WHERE precio_venta = (
SELECT MAX(precio_venta)
FROM producto
);

```
--- 3. Devuelve el nombre del producto del que se han vendido más unidades.  (Tenga en cuenta que tendrá que calcular cuál es el número total de  unidades que se han vendido de cada producto a partir de los datos de la  tabla detalle_pedido)

```sql
SELECT pro.nombre
FROM producto AS pro
INNER JOIN detalle_pedido AS dp ON pro.producto_id = dp.codigo_producto
GROUP BY pro.producto_id
ORDER BY SUM(dp.cantindad) DESC
LIMIT 1;
```
--- 4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya  realizado. (Sin utilizar INNER JOIN). 

```sql

SELECT cli.nombre_cliente, SUM(pa.total)
FROM cliente AS cli 
RIGHT JOIN pago AS pa
ON cli.cliente_id = pa.cliente_id
WHERE cli.limite_credito > pa.total
GROUP BY cli.nombre_cliente;

```
--- 5. Devuelve el producto que más unidades tiene en stock.

```sql
SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto);
```
--- 6. Devuelve el producto que menos unidades tiene en stock. 

```sql
SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);
```
--- 7. Devuelve el nombre, los apellidos y el email de los empleados que están a  cargo de María Martínez. 

```sql
SELECT emp.nombre, emp.apellido1, emp.apellido2, emp.email
FROM empleado AS emp
RIGHT JOIN empleado AS jefe 
ON emp.codigo_jefe_id = jefe.empleado_id
WHERE jefe.nombre = 'María' AND jefe.apellido1 = 'Martínez';
```
**** Subconsultas con ALL y ANY 


---  8. Devuelve el nombre del cliente con mayor límite de crédito. 

```sql
SELECT nombre_cliente
FROM cliente
WHERE limite_credito >= ALL (SELECT limite_credito FROM cliente);
```
--- 9. Devuelve el nombre del producto que tenga el precio de venta más caro. 

```sql
SELECT nombre
FROM producto
WHERE precio_venta >= all (SELECT precio_venta FROM producto);
```
--- 10. Devuelve el producto que menos unidades tiene en stock.

```sql
SELECT nombre
FROM producto
WHERE cantidad_en_stock <= all (SELECT cantidad_en_stock FROM producto);
```
**** Subconsultas con IN y NOT IN 


--- 11. Devuelve el nombre, apellido1 y cargo de los empleados que no  representen a ningún cliente.

```sql
SELECT nombre, apellido1, puesto
FROM empleado
WHERE empleado_id NOT IN (SELECT empleado_id FROM cliente WHERE empleado_id IS NOT NULL);
```
--- 12. Devuelve un listado que muestre solamente los clientes que no han  realizado ningún pago. 


```sql
SELECT nombre_cliente
FROM cliente
WHERE cliente_id NOT IN (SELECT cliente_id FROM pago WHERE cliente_id IS NOT NULL);
```
--- 13. Devuelve un listado que muestre solamente los clientes que sí han realizado  algún pago. 

```sql
SELECT nombre_cliente
FROM cliente
WHERE cliente_id IN (SELECT cliente_id FROM pago WHERE cliente_id IS NOT NULL);
```
--- 14. Devuelve un listado de los productos que nunca han aparecido en un  pedido.

```sql
SELECT nombre 
FROM producto 
WHERE producto_id NOT IN (SELECT codigo_producto FROM detalle_pedido);
```
--- 15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos  empleados que no sean representante de ventas de ningún cliente. 

```sql
SELECT emp.nombre, emp.apellido1, emp.apellido2, emp.puesto, ofi.telefono
FROM empleado AS emp
JOIN oficina AS ofi ON emp.codigo_oficina_id = ofi.oficina_id
WHERE emp.empleado_id NOT IN (SELECT empleado_id FROM cliente WHERE empleado_id IS NOT NULL);
```
--- 16. Devuelve las oficinas donde no trabajan ninguno de los empleados que  hayan sido los representantes de ventas de algún cliente que haya realizado  la compra de algún producto de la gama componentes. 

```sql
SELECT DISTINCT emp.empleado_id
FROM empleado AS emp
JOIN cliente AS cli ON emp.empleado_id = cli.empleado_id
JOIN pedido AS ped ON cli.cliente_id = ped.cliente_id
JOIN detalle_pedido AS dp ON ped.pedido_id = dp.codigo_pedido
JOIN producto AS prod ON dp.codigo_producto = prod.producto_id
WHERE prod.gama_id = 'Componentes';
```
--- 17. Devuelve un listado con los clientes que han realizado algún pedido pero no  han realizado ningún pago. 

```sql
SELECT *
FROM cliente
WHERE cliente_id IN (
SELECT DISTINCT cliente_id
FROM pedido
WHERE pedido_id IN (SELECT DISTINCT pedido_id FROM detalle_pedido)) AND cliente_id NOT IN (SELECT DISTINCT cliente_id FROM pago);
```
**** Subconsultas con EXISTS y NOT EXISTS 


--- 18. Devuelve un listado que muestre solamente los clientes que no han  realizado ningún pago. 

```sql
SELECT cli.nombre_cliente
FROM cliente AS cli
WHERE NOT EXISTS (
    SELECT pa.cliente_id
    FROM pago AS pa
    WHERE pa.cliente_id = cli.cliente_id
);

```
--- 19. Devuelve un listado que muestre solamente los clientes que sí han realizado  algún pago. 

```sql
SELECT cli.nombre_cliente
FROM cliente AS cli
WHERE EXISTS (
    SELECT pa.cliente_id
    FROM pago AS pa
    WHERE pa.cliente_id = cli.cliente_id
);
```
--- 20. Devuelve un listado de los productos que nunca han aparecido en un  pedido. 

```sql
SELECT pro.nombre
FROM producto AS pro
WHERE NOT EXISTS (
    SELECT dp.codigo_producto
    FROM detalle_pedido AS dp
    WHERE dp.codigo_producto = pro.producto_id
);
```
--- 21. Devuelve un listado de los productos que han aparecido en un pedido  alguna vez. 

```sql
SELECT pro.nombre
FROM producto AS pro
WHERE EXISTS (
    SELECT dp.codigo_producto
    FROM detalle_pedido AS dp
    WHERE dp.codigo_producto = pro.producto_id
);
```
**** Subconsultas correlacionadas 

**** Consultas variadas

 
--- 1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos  pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no  han realizado ningún pedido.

```sql
SELECT cli.nombre_cliente, COUNT(ped.cliente_id) AS 'PEDIDOS REALIZADOS'
FROM cliente AS cli
LEFT JOIN pedido AS ped
ON cli.cliente_id = ped.cliente_id
GROUP BY cli.nombre_cliente;
```
--- 2. Devuelve un listado con los nombres de los clientes y el total pagado por  cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han  realizado ningún pago. 

```sql
SELECT cli.nombre_cliente, SUM(pa.total)
FROM cliente AS cli 
LEFT JOIN pago AS pa
ON cli.cliente_id = pa.cliente_id
GROUP BY cli.nombre_cliente;
```
--- 3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008  ordenados alfabéticamente de menor a mayor. 

```sql
SELECT cli.nombre_cliente, year(ped.fecha_pedido) AS 'AÑO'
FROM cliente AS cli
INNER JOIN pedido AS ped
ON cli.cliente_id = ped.cliente_id
WHERE year(ped.fecha_pedido) = 2024
ORDER BY cli.nombre_cliente asc;
```
--- 4. Devuelve el nombre del cliente, el nombre y primer apellido de su  representante de ventas y el número de teléfono de la oficina del  representante de ventas, de aquellos clientes que no hayan realizado ningún  pago. 

```sql
SELECT  cli.nombre_cliente, CONCAT(emp.nombre, ' ', emp.apellido1) AS 'Representante de Ventas', ofi.telefono AS 'Teléfono de la Oficina'
FROM  cliente AS cli
LEFT JOIN pago AS p 
ON cli.cliente_id = p.cliente_id
LEFT JOIN empleado AS emp 
ON cli.empleado_id = emp.empleado_id
LEFT JOIN oficina AS ofi 
ON emp.codigo_oficina_id = ofi.oficina_id
WHERE p.cliente_id IS NULL;
```
--- 5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el  nombre y primer apellido de su representante de ventas y la ciudad donde  está su oficina. 

```sql
SELECT cli.nombre_cliente, CONCAT(emp.nombre, ' ', emp.apellido1) AS 'Representante de Ventas', ciu.nombre AS 'Ciudad de la Oficina'
FROM cliente AS cli
INNER JOIN empleado AS emp 
ON cli.empleado_id = emp.empleado_id
INNER JOIN oficina AS ofi 
ON emp.codigo_oficina_id = ofi.oficina_id
INNER JOIN ciudad AS ciu 
ON ofi.ciudad_id = ciu.ciudad_id;
```
--- 6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos  empleados que no sean representante de ventas de ningún cliente.


```sql
SELECT emp.nombre, emp.apellido1, emp.apellido2, emp.puesto, ofi.telefono
FROM empleado AS emp
INNER JOIN oficina AS ofi 
ON emp.codigo_oficina_id = ofi.oficina_id
WHERE emp.empleado_id NOT IN (
    SELECT DISTINCT empleado_id 
    FROM cliente 
    WHERE empleado_id IS NOT NULL
);
```
--- 7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el  número de empleados que tiene.

```sql
SELECT ciu.nombre, COUNT(emp.empleado_id) AS 'CANTIDAD EMPLEADOS'
FROM ciudad AS ciu
INNER JOIN oficina AS ofi
ON ofi.ciudad_id = ciu.ciudad_id
INNER JOIN empleado AS emp
ON emp.codigo_oficina_id = ofi.oficina_id
GROUP BY ciu.nombre;
```

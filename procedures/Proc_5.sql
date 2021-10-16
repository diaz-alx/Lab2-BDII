/*
Procedimiento almacenado que actualice el pago recibo a los préstamos 
correspondientes. Deberá implementar un cursor que busque los pagos insertados 
uno a uno y los vaya actualizando en la tabla de préstamos y en la tabla sucursales.

1. Para aplicar el pago este debe rebajarlo del saldo prestamos ( 1000-
20)=980.00. Pero debe tomar en cuenta lo siguiente el préstamo paga 
interés y este se calcula sobre el saldo del préstamo (saldo del préstamo * 
tasa de interés%) el pago interés es mensual (1000 * 1%) = 50.00

2. El cálculo del interés lo realiza una Función que es invocada desde
procedimiento.

3. El interés se cobra primero y de quedar alguna porción del monto pagado
por el cliente se aplica al saldo del préstamo.

4. La tabla de sucursales solo almacena los monto prestados por la empresa 
financiera en función de esto, aplicar las actualizaciones.

*/
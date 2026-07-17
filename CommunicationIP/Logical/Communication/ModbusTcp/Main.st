
PROGRAM _INIT
	(* Insert code here *)
	TON_SendMessage.IN	:= TRUE;
	TON_SendMessage.PT	:= T#4s;
	TON_SendMessage();
	TON_SendBatchMessage.IN	:= TRUE;
	TON_SendBatchMessage.PT	:= T#4s;
	TON_SendBatchMessage();
	
	
END_PROGRAM

PROGRAM _CYCLIC
	
	Modbus.SensorBar.StatusSensorBar;
	
	(* Actions *) 
	actMeasurement;
	actBatch;
	
	(* Bloques de funcion *)
	TON_SendMessage();
	TON_SendBatchMessage();
END_PROGRAM


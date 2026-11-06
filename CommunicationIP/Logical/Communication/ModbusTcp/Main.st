
PROGRAM _INIT

	TimeIdle	:= 2000;
	
	
END_PROGRAM

PROGRAM _CYCLIC
	
	
	actParameters;	(* * * ACTION - Parametros de tiempo de calentamiento y avance de motor * * *) 
	
	(* Estado de sensores de la barra de medir *) 
	Modbus.sensorBar.statusSensorBar;
	

	(* * * CONDICIONES PARA ENVIO DE DATOS * * *)
	CASE Modbus.state OF
		(* * * * * * * * *  ESTADO DE ESPERA   * * * * * * * * *)
		MODBUS_WAIT:
			
			IF Modbus.cmd.manualMode THEN
	  			Modbus.state:= MODBUS_MAN_SEND_DATA;
			ELSIF Modbus.cmd.autoMode THEN
				Modbus.state:= MODBUS_AUT_SEND_DATA;
			END_IF;
			
		(* * * * * * * * *  ESTADO MANUAL   * * * * * * * * *)
		MODBUS_MAN_SEND_DATA:
			
			(* Condiciones necesarias para envio de datos *)
			IF (Modbus.mesuringStamper.trigger = 0) AND (Modbus.batchStamper.trigger = 0) 
				AND (TON_MotorTime.IN = FALSE)	THEN
				(* TIEMPO DE AVANCE DE MOTOR *) 
				TON_MotorTime.IN := TRUE;
				(* Trigger y action con datos de medicion *)
				Modbus.mesuringStamper.trigger	:= 1; 
				actMeasurement; (* * * ACTION CON DATOS DE MEDICION * * *)
				(* Trigger y datos de lote *)
				Modbus.batchStamper.trigger		:= 1;
				actBatch;		(* * * ACTION CON DATOS DE LOTE * * *)
			ELSIF (Modbus.mesuringStamper.trigger = 0) AND (Modbus.batchStamper.trigger = 0) 
				AND (TON_MotorTime.Q = TRUE) THEN
				(* Cambio de estado *)
				TON_MotorTime.IN 		:= FALSE;
				Modbus.cmd.manualMode	:= FALSE;
				Modbus.state	:= MODBUS_WAIT;	
			END_IF;
			
		(* * * * * * * * *  ESTADO DE AUTOMATICO  * * * * * * * * *)	
		MODBUS_AUT_SEND_DATA:
		
			(* Condiciones necesarias para envio de datos *)
			IF (Modbus.mesuringStamper.trigger = 0) AND (Modbus.batchStamper.trigger = 0) 
				AND (TON_AutoMode.IN = FALSE)	THEN
				(* TIEMPO DE AVANCE DE MOTOR *) 
				TON_AutoMode.IN := TRUE;
				(* Trigger y action con datos de medicion *)
				Modbus.mesuringStamper.trigger	:= 1; 
				actMeasurement; (* * * ACTION CON DATOS DE MEDICION * * *)
				(* Trigger y datos de lote *)
				Modbus.batchStamper.trigger		:= 1;
				actBatch;		(* * * ACTION CON DATOS DE LOTE * * *)
			ELSIF ((Modbus.mesuringStamper.trigger = 0) AND (Modbus.batchStamper.trigger = 0) 
				AND (TON_AutoMode.Q = TRUE)) OR NOT(Modbus.cmd.autoMode) THEN
				(* Cambio de estado *)
				TON_AutoMode.IN := FALSE;
				Modbus.state	:= MODBUS_WAIT;	
			END_IF;
			

	END_CASE;
	

END_PROGRAM


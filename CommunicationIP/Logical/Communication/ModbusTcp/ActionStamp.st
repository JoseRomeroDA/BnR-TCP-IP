ACTION actParameters:
	(* Parametros de tiempo de calentamiento y avance de motor *) 
	
	(*LOTE - TIEMPO DE AVANCE DEL MOTOR DEL RIBBON*) 
	Modbus.batchStamper.param.motorTime;
	IF ((Modbus.batchStamper.param.motorTime <> OldParamMotorTimeBatch)
		AND NOT(Modbus.batchStamper.sendBatchOk)) THEN
		Modbus.batchStamper.sendParamMotor	:= TRUE;
	END_IF
	IF Modbus.batchStamper.sendParamMotorOk THEN
		OldParamMotorTimeBatch	:= Modbus.batchStamper.param.motorTime; 
		Modbus.batchStamper.sendParamMotor	:= FALSE;
	END_IF
	
	(* LOTE - TIEMPO DE CALENTAMIENTO DE LA TARJETA DE ESTAMPADO *)
	Modbus.batchStamper.param.warmingTime;
	IF ((Modbus.batchStamper.param.warmingTime <> OldParamWarmingTimeBatch)
		AND NOT(Modbus.batchStamper.sendParamWarmingOk)) THEN
		Modbus.batchStamper.sendParamWarming:= TRUE;
	END_IF
	IF Modbus.batchStamper.sendParamWarmingOk THEN
		OldParamWarmingTimeBatch	:= Modbus.batchStamper.param.warmingTime;
		Modbus.batchStamper.sendParamWarming:= FALSE;
	END_IF
	
	(*MEDICION - TIEMPO DE CALENTAMIENTO DE LA TARJETA DE ESTAMPADO*)
	Modbus.mesuringStamper.param.warmingTime;
	IF ((Modbus.mesuringStamper.param.warmingTime <> OldParamWarmingTimeMeasuring)
		AND NOT(Modbus.mesuringStamper.sendParamWarmingOk)) THEN
		Modbus.mesuringStamper.sendParamWarming := TRUE;
	END_IF
	IF Modbus.mesuringStamper.sendParamWarmingOk THEN
		OldParamWarmingTimeMeasuring	:= Modbus.mesuringStamper.param.warmingTime;
		Modbus.mesuringStamper.sendParamWarming	:= FALSE;
	END_IF;

	(* Parametros de tiempo para el motor y el modo automatico *)
	TON_MotorTime.PT	:= UINT_TO_TIME(Modbus.batchStamper.param.motorTime);
	TON_AutoMode.PT		:= UINT_TO_TIME(TimeIdle + Modbus.batchStamper.param.motorTime);
	
	(* * * LLAMADO DE BLOQUE DE FUNCIONES * * *)
	TON_MotorTime();
	TON_AutoMode();

	  
END_ACTION

(* * * ACTION CON DATOS DE MEDICION * * *)
ACTION actMeasurement: 
	
	(* Datos de medicion *) 
	Modbus.mesuringStamper.unit	:= 1;
	Modbus.mesuringStamper.digits	:= Modbus.mesuringStamper.digits + 1;
	Modbus.mesuringStamper.class	:= Modbus.mesuringStamper.class + 1;
	
	(* Aumento variables en digitos *)
	IF Modbus.mesuringStamper.digits >= 999 THEN 
		Modbus.mesuringStamper.digits := 0;
	END_IF;
	(* Aumento variables en clase *)
	IF Modbus.mesuringStamper.class >= 9 THEN
		Modbus.mesuringStamper.class := 0;
	END_IF;
	
END_ACTION

ACTION actBatch:
	
	(* Datos de lote *)
	Modbus.batchStamper.digits[1]	:= Modbus.batchStamper.digits[1] + 1;
	Modbus.batchStamper.digits[2] 	:= Modbus.batchStamper.digits[2] + 1;
	
	(* Aumento de variables de los digitos *)
	IF Modbus.batchStamper.digits[1] >= 999 THEN
		Modbus.batchStamper.digits[1] := 0;
		Modbus.batchStamper.digits[2] := 0;
	END_IF; 
	
	
END_ACTION

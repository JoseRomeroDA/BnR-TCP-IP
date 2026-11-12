ACTION actParameters:
	(* Parametros de tiempo de calentamiento y avance de motor *) 
	
	(*LOTE - TIEMPO DE AVANCE DEL MOTOR DEL RIBBON*) 
	Modbus.batchStamper.param.motorTime := ModbusParam.motorTime[1];
	IF ((Modbus.batchStamper.param.motorTime <> OldParamMotorTimeBatch)
		AND NOT(Modbus.batchStamper.sendBatchOk)) THEN
		Modbus.batchStamper.sendParamMotor	:= TRUE;
	END_IF
	IF Modbus.batchStamper.sendParamMotorOk THEN
		OldParamMotorTimeBatch	:= Modbus.batchStamper.param.motorTime; 
		Modbus.batchStamper.sendParamMotor	:= FALSE;
	END_IF
	
	(* LOTE - TIEMPO DE CALENTAMIENTO DE LA TARJETA DE ESTAMPADO *)
	Modbus.batchStamper.param.warmingTime	:= ModbusParam.warmingTime[1];
	IF ((Modbus.batchStamper.param.warmingTime <> OldParamWarmingTimeBatch)
		AND NOT(Modbus.batchStamper.sendParamWarmingOk)) THEN
		Modbus.batchStamper.sendParamWarming:= TRUE;
	END_IF
	IF Modbus.batchStamper.sendParamWarmingOk THEN
		OldParamWarmingTimeBatch	:= Modbus.batchStamper.param.warmingTime;
		Modbus.batchStamper.sendParamWarming:= FALSE;
	END_IF
	
	(*MEDICION - TIEMPO DE CALENTAMIENTO DE LA TARJETA DE ESTAMPADO*)
	Modbus.measuringStamper.param.warmingTime	:= ModbusParam.warmingTime[2];
	IF ((Modbus.measuringStamper.param.warmingTime <> OldParamWarmingTimeMeasuring)
		AND NOT(Modbus.measuringStamper.sendParamWarmingOk)) THEN
		Modbus.measuringStamper.sendParamWarming := TRUE;
	END_IF
	IF Modbus.measuringStamper.sendParamWarmingOk THEN
		OldParamWarmingTimeMeasuring	:= Modbus.measuringStamper.param.warmingTime;
		Modbus.measuringStamper.sendParamWarming	:= FALSE;
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
	Modbus.measuringStamper.unit	:= 1;
	Modbus.measuringStamper.digits	:= Modbus.measuringStamper.digits + 1;
	Modbus.measuringStamper.class	:= Modbus.measuringStamper.class + 1;
	
	(* Aumento variables en digitos *)
	IF Modbus.measuringStamper.digits >= 999 THEN 
		Modbus.measuringStamper.digits := 0;
	END_IF;
	(* Aumento variables en clase *)
	IF Modbus.measuringStamper.class >= 9 THEN
		Modbus.measuringStamper.class := 0;
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

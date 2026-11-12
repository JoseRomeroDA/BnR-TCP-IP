
TYPE
	Modbus_typ : 	STRUCT 
		cmd : Modbus_cmd_typ;
		state : Modbus_state_typ;
		measuringStamper : MeasuringStamper_typ;
		batchStamper : BatchStamper_typ;
		sensorBar : SensorBar_typ;
	END_STRUCT;
	Modbus_cmd_typ : 	STRUCT 
		manualMode : BOOL;
		autoMode : BOOL;
	END_STRUCT;
	Modbus_state_typ : 
		(
		MODBUS_WAIT := 0,
		MODBUS_MAN_SEND_DATA := 10,
		MODBUS_AUT_SEND_DATA := 20
		);
	MeasuringStamper_typ : 	STRUCT 
		ModuleOk : BOOL;
		trigger : UINT;
		unit : UINT;
		digits : UINT;
		class : UINT;
		sendMeasuring : BOOL;
		sendMeasuringOk : BOOL;
		sendParamWarming : BOOL;
		sendParamWarmingOk : BOOL;
		param : Measuring_param_typ;
	END_STRUCT;
	BatchStamper_typ : 	STRUCT 
		ModuleOk : BOOL;
		trigger : UINT;
		digits : ARRAY[1..2]OF UINT;
		sendBatch : BOOL;
		sendBatchOk : BOOL;
		sendParamMotorOk : BOOL;
		sendParamMotor : BOOL;
		sendParamWarming : BOOL;
		sendParamWarmingOk : BOOL;
		param : Batch_param_typ;
	END_STRUCT;
	SensorBar_typ : 	STRUCT 
		ModuleOk : BOOL;
		statusSensorBar : UINT;
	END_STRUCT;
	Modbus_param_typ : 	STRUCT 
		warmingTime : ARRAY[1..2]OF UINT; (*Tiempo de calentamiento de placas*)
		motorTime : ARRAY[1..2]OF UINT; (*Tiempo de avance de motor*)
	END_STRUCT;
	Measuring_param_typ : 	STRUCT 
		warmingTime : UINT;
	END_STRUCT;
	Batch_param_typ : 	STRUCT 
		warmingTime : UINT;
		motorTime : UINT;
	END_STRUCT;
END_TYPE

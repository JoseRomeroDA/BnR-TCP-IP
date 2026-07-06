
TYPE
	Modbus_typ : 	STRUCT 
		Stamper : Stamper_typ;
		SensorBar : SensorBar_typ;
	END_STRUCT;
	Stamper_typ : 	STRUCT 
		Unit : USINT;
		Measurement : UINT;
		Confirm : USINT;
		Confirmed : USINT;
	END_STRUCT;
	SensorBar_typ : 	STRUCT 
		StatusSensorBar : USINT;
	END_STRUCT;
END_TYPE


TYPE
	Modbus_typ : 	STRUCT 
		MesuringStamper : MeasuringStamper_typ;
		BatchStamper : BatchStamper_typ;
		SensorBar : SensorBar_typ;
	END_STRUCT;
	MeasuringStamper_typ : 	STRUCT 
		Trigger : UINT;
		Unidad : UINT;
		Digitos : UINT;
		Clase : UINT;
		Send : BOOL;
		SendOk : BOOL;
	END_STRUCT;
	BatchStamper_typ : 	STRUCT 
		Trigger : UINT;
		Digitos : ARRAY[1..2]OF UINT;
		Send : BOOL;
		SendOk : BOOL;
	END_STRUCT;
	SensorBar_typ : 	STRUCT 
		StatusSensorBar : UINT;
	END_STRUCT;
END_TYPE


PROGRAM _INIT
	(* Insert code here *)
	Modbus.Stamper.Measurement := 0;
	TON_SendMessage.IN	:= TRUE;
	TON_SendMessage.PT	:= T#2s;
	TON_SendMessage();
END_PROGRAM

PROGRAM _CYCLIC
	
	Modbus.SensorBar.StatusSensorBar;
	
	IF NOT TON_SendMessage.IN THEN
		TON_SendMessage.IN := TRUE;
	END_IF;
	
	IF TON_SendMessage.Q AND (Modbus.Stamper.Confirm = 0) AND CommisionalMode THEN
		TON_SendMessage.IN			:= FALSE;
		Modbus.Stamper.Unit 		:= 1;		
		Modbus.Stamper.Measurement 	:= Modbus.Stamper.Measurement + 1;
		Modbus.Stamper.Confirm		:= 1;
	END_IF;
	
	IF Modbus.Stamper.Measurement >= 990 THEN 
		Modbus.Stamper.Measurement := 10 ;
	END_IF;
	
	TON_SendMessage();

END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM



ACTION actMeasurement: 
	(* Logica para testear el control del estampado de medicion *)
	IF NOT TON_SendMessage.IN AND Modbus.MesuringStamper.SendOk  THEN
		Modbus.MesuringStamper.Send	:= FALSE;
		TON_SendMessage.IN 			:= TRUE;
	END_IF;
	
	IF TON_SendMessage.Q AND (Modbus.MesuringStamper.Trigger = 0) AND CommisionalMode1 THEN
		TON_SendMessage.IN 				:= FALSE;
		Modbus.MesuringStamper.Send		:= TRUE;
		Modbus.MesuringStamper.Trigger	:= 1; 
		Modbus.MesuringStamper.Unidad	:= 1;
		Modbus.MesuringStamper.Digitos	:= Modbus.MesuringStamper.Digitos + 1;
		Modbus.MesuringStamper.Clase	:= Modbus.MesuringStamper.Clase + 1;
	END_IF;

	IF Modbus.MesuringStamper.Digitos >= 999 THEN 
		Modbus.MesuringStamper.Digitos := 0;
	END_IF;
	
	IF Modbus.MesuringStamper.Clase >= 9 THEN
		Modbus.MesuringStamper.Clase := 0;
	END_IF;
	
END_ACTION

ACTION actBatch :
	(* Logica para testear el control de estampado de lote *)
	IF NOT TON_SendBatchMessage.IN AND Modbus.BatchStamper.SendOk THEN
		TON_SendBatchMessage.IN		:= TRUE;
		Modbus.BatchStamper.Send	:= FALSE;	
	END_IF;
	 	
	IF TON_SendBatchMessage.Q AND (Modbus.BatchStamper.Trigger = 0) AND CommisionalMode1 THEN
		TON_SendBatchMessage.IN			:= FALSE;
		Modbus.BatchStamper.Send		:= TRUE;
		Modbus.BatchStamper.Trigger 	:= 1;
		Modbus.BatchStamper.Digitos[1] 	:= Modbus.BatchStamper.Digitos[1] + 1;
		Modbus.BatchStamper.Digitos[2] 	:= Modbus.BatchStamper.Digitos[2] + 1;
	END_IF;
	
	IF Modbus.BatchStamper.Digitos[1] >= 999 THEN
		Modbus.BatchStamper.Digitos[1] := 0;
		Modbus.BatchStamper.Digitos[2] := 0;
	END_IF; 
	
END_ACTION

within TPPSim.Sensors;
type TemperatureType = enumeration(subcooling "Недогрев до температуры насыщения", overheating "Перегрев свыше температуры насыщения", saturation "Температура на линии насыщения при данном давлении") "Тип датчика температуры (недогрев/перегрев)";

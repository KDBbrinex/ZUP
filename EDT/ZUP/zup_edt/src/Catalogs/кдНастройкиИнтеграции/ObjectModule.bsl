

Функция ПолучитьПароль() экспорт
	
	ТекПароль = Пароль.Получить();
	Возврат ?(НЕ ЗначениеЗаполнено(ТекПароль),"",ТекПароль);

КонецФункции // ()

Функция Параметр(ИмяПараметра, значениеПоУмолчанию = Неопределено) экспорт
	НайдСтрока = ДопПараметры.Найти(ИмяПараметра,"Параметр");
	Если НайдСтрока=Неопределено Тогда
		Возврат значениеПоУмолчанию;
	Иначе	
		Возврат НайдСтрока.Значение;
	КонецЕсли;
КонецФункции // ()

Функция СтрПараметры() Экспорт
	стрПарам = новый Структура;
	Для каждого ТекСтрока Из ДопПараметры Цикл
		стрПарам.Вставить(ТекСтрока.Параметр, ТекСтрока.Значение);
	КонецЦикла;
	
	//Начало: Хафизов Ф.Ф., Настройки интеграции 20.02.2019
	Возврат стрПарам;
	//Конец:  Хафизов Ф.Ф., Настройки интеграции 20.02.2019
КонецФункции // ()

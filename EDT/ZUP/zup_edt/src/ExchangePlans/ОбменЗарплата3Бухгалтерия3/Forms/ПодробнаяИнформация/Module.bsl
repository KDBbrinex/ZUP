
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Макет = ПланыОбмена.ОбменЗарплата3Бухгалтерия3.ПолучитьМакет("ПодробнаяИнформация");
	
	ПолеHTMLДокумента = Макет.ПолучитьТекст();
	
	Заголовок = НСтр("ru = 'Информация о синхронизации данных с Бухгалтерия Предприятия, редакция 3.0'");

КонецПроцедуры

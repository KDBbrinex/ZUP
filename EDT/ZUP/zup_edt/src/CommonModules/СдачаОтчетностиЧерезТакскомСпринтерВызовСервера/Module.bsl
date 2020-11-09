
#Область ПрограммныйИнтерфейс

Функция ПолучитьНастройкиИнтеграцииСоСпринтером(ОрганизацияСсылка) Экспорт
	Запрос = Новый Запрос;
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	НастройкиИнтеграцииСоСпринтером.КодАбонента,
	|	НастройкиИнтеграцииСоСпринтером.КаталогПрограммыЭлектроннойПочты,
	|	НастройкиИнтеграцииСоСпринтером.КаталогОтправкиДанныхОтчетности
	|ИЗ
	|	РегистрСведений.НастройкиИнтеграцииСоСпринтером КАК НастройкиИнтеграцииСоСпринтером
	|ГДЕ
	|	НастройкиИнтеграцииСоСпринтером.Организация = &ОрганизацияСсылка
	|	И НастройкиИнтеграцииСоСпринтером.Организация.ВидОбменаСКонтролирующимиОрганами = &ОбменЧерезСпринтер";
	
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("ОрганизацияСсылка", ОрганизацияСсылка);
	Запрос.УстановитьПараметр("ОбменЧерезСпринтер", Перечисления.ВидыОбменаСКонтролирующимиОрганами.ОбменЧерезСпринтер);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если НЕ Выборка.Следующий() Тогда
		Возврат Неопределено;	
	Иначе
		
		КодАбонента = Выборка.КодАбонента;
		КаталогПрограммыЭлектроннойПочты = СокрЛП(Выборка.КаталогПрограммыЭлектроннойПочты);
		КаталогОтправкиДанныхОтчетности = СокрЛП(Выборка.КаталогОтправкиДанныхОтчетности);
		
		//нормализуем каталоги
		СдачаОтчетностиЧерезТакскомСпринтерКлиентСервер.НормализоватьКаталог(КаталогПрограммыЭлектроннойПочты);
		СдачаОтчетностиЧерезТакскомСпринтерКлиентСервер.НормализоватьКаталог(КаталогОтправкиДанныхОтчетности);
		
		
		Возврат Новый Структура("КодАбонента, КаталогПрограммыЭлектроннойПочты, КаталогОтправкиДанныхОтчетности", 
								 КодАбонента, КаталогПрограммыЭлектроннойПочты, КаталогОтправкиДанныхОтчетности);
	КонецЕсли;
КонецФункции

#КонецОбласти


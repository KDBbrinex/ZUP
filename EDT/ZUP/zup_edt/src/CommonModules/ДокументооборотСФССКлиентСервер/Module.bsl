
#Область ПрограммныйИнтерфейс

Процедура УстановитьВидимостьГруппыКнопокОтправки(Форма, ПараметрыПрорисовкиКнопокОтправки) Экспорт
	
	Для Каждого Эл Из ПараметрыПрорисовкиКнопокОтправки Цикл
		ЭУ = Форма.Элементы.Найти(Эл.Ключ);
		Если ЭУ <> Неопределено Тогда
			ЭУ.Видимость = Эл.Значение;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура ПриИнициализацииФормыРегламентированногоОтчета(Форма, ПараметрыПрорисовкиПанели = Неопределено) Экспорт
	
	// если кнопка отправки отсутствует, то не будем регулировать
	КнопкаОтправитьВКонтролирующийОрган = Форма.Элементы.Найти("ОтправитьВКонтролирующийОрган");
	Если КнопкаОтправитьВКонтролирующийОрган = Неопределено Тогда
		КнопкаОтправитьВКонтролирующийОрган = Форма.Элементы.Найти("ФормаОтправитьРеестрВФСС");
		Если КнопкаОтправитьВКонтролирующийОрган = Неопределено Тогда
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	ОрганизацияСсылка = ПолучитьОрганизациюПоФорме(Форма);
	
	// прорисовываем кнопки отправки
	ПараметрыПрорисовкиКнопокОтправки   = ПараметрыПрорисовкиКнопокОтправки(ОрганизацияСсылка);
	// прорисовываем панель отправки
	ПараметрыПрорисовкиПанели 			= ПолучитьПараметрыПрорисовкиПанелиОтправки(Форма);
	
	// регулируем видимость кнопки в зависимости от результата
	УстановитьВидимостьГруппыКнопокОтправки(Форма, ПараметрыПрорисовкиКнопокОтправки);
	
КонецПроцедуры

Функция ПараметрыПрорисовкиКнопокОтправки(ОрганизацияСсылка) Экспорт
	
	ПараметрыПрорисовкиКнопокОтправки = Новый Структура;
	
	ПараметрыПрорисовкиКнопокОтправки.Вставить("ГруппаОтправкаВКонтролирующийОрган", Истина);
	
	НастройкиОбмена = ДокументооборотСКОВызовСервера.ПолучитьНастройкиФСС(ОрганизацияСсылка);
	ИспользоватьОбмен = НастройкиОбмена.ИспользоватьОбмен;
	ОнлайнПроверкаДоступна = НастройкиОбмена.ОнлайнПроверкаДоступна;
	
	Если НЕ ИспользоватьОбмен Тогда
		ПараметрыПрорисовкиКнопокОтправки.Вставить("ФормаИсторияОтправок", Ложь);
	КонецЕсли;
	
	УчетнаяЗапись = ДокументооборотСКОВызовСервера.УчетнаяЗаписьОрганизации(ОрганизацияСсылка);
	Если ЗначениеЗаполнено(УчетнаяЗапись) Тогда
		Если НЕ ОнлайнПроверкаДоступна Тогда
			ПараметрыПрорисовкиКнопокОтправки.Вставить("ПроверитьВИнтернете", Ложь);
		КонецЕсли;
	Иначе
		// Если нет учетной записи, то оставляем меню ПроверитьВИнтернете, чтобы по нему показывать предложение подключиться
		ПараметрыПрорисовкиКнопокОтправки.Вставить("ПроверитьВИнтернете", Истина);
	КонецЕсли;
	
	Возврат ПараметрыПрорисовкиКнопокОтправки;
	
КонецФункции

Процедура ПриИзмененииОрганизацииВРегламентированномОтчете(Форма) Экспорт
	
	// если кнопка отправки отсутствует, то не будем регулировать
	КнопкаОтправитьВКонтролирующийОрган = Форма.Элементы.Найти("ОтправитьВКонтролирующийОрган");
	Если КнопкаОтправитьВКонтролирующийОрган = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОрганизацияСсылка = ПолучитьОрганизациюПоФорме(Форма);
	ПараметрыПрорисовкиКнопокОтправки = Новый Структура;
	
	ПараметрыПрорисовкиКнопокОтправки.Вставить("ГруппаОтправкаВКонтролирующийОрган", Истина);
	
	НастройкиОбмена = ДокументооборотСКОВызовСервера.ПолучитьНастройкиФСС(ОрганизацияСсылка);
	ИспользоватьОбмен = НастройкиОбмена.ИспользоватьОбмен;
	ОнлайнПроверкаДоступна = НастройкиОбмена.ОнлайнПроверкаДоступна;
	
	ПараметрыПрорисовкиКнопокОтправки.Вставить("ФормаИсторияОтправок", ИспользоватьОбмен);
	
	ПараметрыПрорисовкиКнопокОтправки.Вставить("ПроверитьВИнтернете", ОнлайнПроверкаДоступна);
	
	// прорисовываем панель отправки
	ПараметрыПрорисовкиПанели = ПолучитьПараметрыПрорисовкиПанелиОтправки(Форма);
	
	// регулируем видимость кнопки в зависимости от результата
	УстановитьВидимостьГруппыКнопокОтправки(Форма, ПараметрыПрорисовкиКнопокОтправки);
	
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиентСервер.ПрименитьПараметрыПрорисовкиПанелиОтправки(Форма, ПараметрыПрорисовкиПанели);
	
КонецПроцедуры

Функция ПолучитьПараметрыПрорисовкиПанелиОтправки(Форма) Экспорт
	
	ОтчетСсылка 		= СсылкаНаОтчетПоФорме(Форма);
	ОрганизацияСсылка 	= ПолучитьОрганизациюПоФорме(Форма);
	ПараметрыПрорисовкиПанелиОтправки = ДокументооборотСКОВызовСервера.ПараметрыПрорисовкиПанелиОтправки(ОтчетСсылка, ОрганизацияСсылка, "ФСС");
		
	Возврат ПараметрыПрорисовкиПанелиОтправки;
	
КонецФункции

Функция СсылкаНаОтчетПоФорме(Форма) Экспорт
	
	Если РегламентированнаяОтчетностьКлиентСервер.СвойствоОпределено(Форма, "СтруктураРеквизитовФормы")
		И РегламентированнаяОтчетностьКлиентСервер.СвойствоОпределено(Форма.СтруктураРеквизитовФормы, "мСохраненныйДок") Тогда
		Возврат Форма.СтруктураРеквизитовФормы.мСохраненныйДок;
	ИначеЕсли РегламентированнаяОтчетностьКлиентСервер.СвойствоОпределено(Форма, "Объект")
		И РегламентированнаяОтчетностьКлиентСервер.СвойствоОпределено(Форма.Объект, "Ссылка") Тогда
		Возврат Форма.Объект.Ссылка;
	ИначеЕсли СтрНайти(Форма.ИмяФормы, "ДлительнаяОперация") <> 0
		И РегламентированнаяОтчетностьКлиентСервер.СвойствоОпределено(Форма, "ОтчетСсылка") Тогда
		Возврат Форма.ОтчетСсылка;
	Иначе
		Возврат ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиентСерверПереопределяемый.ПолучитьСсылкуНаОтправляемыйДокументПоФорме(Форма);
	КонецЕсли;
	
КонецФункции

Функция ПолучитьОрганизациюПоФорме(Форма) Экспорт
	
	Если РегламентированнаяОтчетностьКлиентСервер.СвойствоОпределено(Форма, "СтруктураРеквизитовФормы")
		И РегламентированнаяОтчетностьКлиентСервер.СвойствоОпределено(Форма.СтруктураРеквизитовФормы, "Организация") Тогда
		Возврат Форма.СтруктураРеквизитовФормы.Организация;
	ИначеЕсли РегламентированнаяОтчетностьКлиентСервер.СвойствоОпределено(Форма, "Объект")
		И РегламентированнаяОтчетностьКлиентСервер.СвойствоОпределено(Форма.Объект, "Организация") Тогда
		Возврат Форма.Объект.Организация;
	ИначеЕсли СтрНайти(Форма.ИмяФормы, "ДлительнаяОперация") <> 0
		И РегламентированнаяОтчетностьКлиентСервер.СвойствоОпределено(Форма, "ТекущаяОрганизация") Тогда
		Возврат Форма.ТекущаяОрганизация;
	Иначе
		Возврат ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиентСерверПереопределяемый.ПолучитьСсылкуНаОрганизациюОтправляемогоДокументаПоФорме(Форма);
	КонецЕсли;
	
КонецФункции

// Функция возвращает признак того, является ли документ, ссылка на который 
// передается в параметре, реестром сведений ФСС на выплату пособий, 
// предназначенным для формирования и отправки файла выгрузки в ФСС
// 
// Параметры:
//	Ссылка на документ.
//
// Результат:
//	Булево.
//
Функция ЭтоРеестрСведенийНаВыплатуПособийФСС(ОбъектСсылка) Экспорт
	
	ТипЗнчСсылкаНаОтчет = ТипЗнч(ОбъектСсылка);
	ИмяДокументаРеестрСведенийНаВыплатуПособийФСС 	= ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиентСерверПереопределяемый.ИмяОбъектаМетаданных("РеестрСведенийНаВыплатуПособийФСС");
	Если ИмяДокументаРеестрСведенийНаВыплатуПособийФСС <> Неопределено И ТипЗнчСсылкаНаОтчет = Тип("ДокументСсылка." + ИмяДокументаРеестрСведенийНаВыплатуПособийФСС) Тогда
		ЭтоРеестрСведений = Истина;
	Иначе
		ЭтоРеестрСведений = Ложь;
	КонецЕсли;
	
	Возврат ЭтоРеестрСведений;
	
КонецФункции

// Функция возвращает признак того, является ли документ, ссылка на который
// передается в параметре, реестром данных ЭЛН, заполняемых работодателем,
// предназначенным для формирования и отправки файла выгрузки в ФСС
//
// Параметры:
//	Ссылка на документ.
//
// Результат:
//	Булево.
//
Функция ЭтоРеестрДанныхЭЛНЗаполняемыхРаботодателем(ОбъектСсылка, ОбъектМетаданныхПоУмолчаниюСуществует = Ложь) Экспорт
	
	ТипЗнчСсылкаНаОтчет = ТипЗнч(ОбъектСсылка);
	ИмяДокументаРеестрДанныхЭЛНЗаполняемыхРаботодателем =
		ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиентСерверПереопределяемый.ИмяОбъектаМетаданных(
		"РеестрДанныхЭЛНЗаполняемыхРаботодателем");
	Если ИмяДокументаРеестрДанныхЭЛНЗаполняемыхРаботодателем = Неопределено И ОбъектМетаданныхПоУмолчаниюСуществует Тогда
		ИмяДокументаРеестрДанныхЭЛНЗаполняемыхРаботодателем = "РеестрДанныхЭЛНЗаполняемыхРаботодателем";
	КонецЕсли;
	
	Возврат ИмяДокументаРеестрДанныхЭЛНЗаполняемыхРаботодателем <> Неопределено
		И ТипЗнчСсылкаНаОтчет = Тип("ДокументСсылка." + ИмяДокументаРеестрДанныхЭЛНЗаполняемыхРаботодателем);
	
КонецФункции

#КонецОбласти
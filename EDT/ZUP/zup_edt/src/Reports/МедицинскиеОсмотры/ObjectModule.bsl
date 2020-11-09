#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	ИнициализироватьОтчет();
	ЗарплатаКадрыОтчеты.ПриКомпоновкеРезультатаВТабличныйДокумент(ЭтотОбъект, ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка, Ложь);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ИнициализироватьОтчет() Экспорт
	
	ДополнительныеПоляПредставлений = ДополнительныеПоляПредставленийОтчетовПоСотрудникам();
	
	Если ДополнительныеПоляПредставлений = Неопределено Тогда
		СоответствиеДополнительныхПолейПредставлениям = Неопределено;
	Иначе
		СоответствиеДополнительныхПолейПредставлениям = Новый Структура;
		СоответствиеДополнительныхПолейПредставлениям.Вставить("Представления_СотрудникиОрганизации", ДополнительныеПоляПредставлений);
	КонецЕсли;
	
	ЗарплатаКадрыОбщиеНаборыДанных.ЗаполнитьОбщиеИсточникиДанныхОтчета(ЭтотОбъект, СоответствиеДополнительныхПолейПредставлениям);
	
КонецПроцедуры

// Для общей формы "Форма отчета" подсистемы "Варианты отчетов".
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	
	Настройки.События.ПередЗагрузкойНастроекВКомпоновщик = Истина;
	
КонецПроцедуры

// Вызывается перед загрузкой новых настроек. Используется для изменения схемы компоновки.
//
Процедура ПередЗагрузкойНастроекВКомпоновщик(Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД) Экспорт
	
	Если КлючСхемы <> "СхемаИнициализирована" Тогда
		
		ИнициализироватьОтчет();
		ОтчетыСервер.ПодключитьСхему(ЭтотОбъект, Контекст, СхемаКомпоновкиДанных, КлючСхемы);
		
		КлючСхемы = "СхемаИнициализирована";
		
	КонецЕсли;
	
КонецПроцедуры

// Вызывается в обработчике одноименного события формы отчета после выполнения кода формы.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения - Форма отчета.
//   Отказ - Передается из параметров обработчика "как есть".
//   СтандартнаяОбработка - Передается из параметров обработчика "как есть".
//
// См. также:
//   "ФормаКлиентскогоПриложения.ПриСозданииНаСервере" в синтакс-помощнике.
//
Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	ИнициализироватьОтчет();
	ЗначениеВДанныеФормы(ЭтотОбъект, Форма.Отчет);
	
КонецПроцедуры

Функция ДополнительныеПоляПредставленийОтчетовПоСотрудникам()
	
	ДополнительныеПоляПредставлений = ЗарплатаКадрыОбщиеНаборыДанных.ПустаяТаблицаДополнительныхПолейПредставлений();
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.Медицина") Тогда
		МодульМедицина = ОбщегоНазначения.ОбщийМодуль("Медицина");
		МодульМедицина.ДополнитьТаблицуДополнительныхПолейПредставленийОтчетовПоСотрудникам(ДополнительныеПоляПредставлений);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба") Тогда
		МодульГосударственнаяСлужба = ОбщегоНазначения.ОбщийМодуль("ГосударственнаяСлужба");
		МодульГосударственнаяСлужба.ДополнитьТаблицуДополнительныхПолейПредставленийОтчетовПоСотрудникам(ДополнительныеПоляПредставлений);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ОрганизационнаяСтруктура") Тогда
		МодульОрганизационнаяСтруктура = ОбщегоНазначения.ОбщийМодуль("ОрганизационнаяСтруктура");
		МодульОрганизационнаяСтруктура.ДополнитьТаблицуДополнительныхПолейПредставленийОтчетовПоСотрудникам(ДополнительныеПоляПредставлений);
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.ИспытательныйСрокСотрудников") Тогда
		МодульИспытательныйСрок = ОбщегоНазначения.ОбщийМодуль("ИспытательныйСрокСотрудников");
		МодульИспытательныйСрок.ДополнитьТаблицуДополнительныхПолейПредставленийОтчетовПоСотрудникам(ДополнительныеПоляПредставлений);
	КонецЕсли;
	
	Возврат ДополнительныеПоляПредставлений;
	
КонецФункции

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли
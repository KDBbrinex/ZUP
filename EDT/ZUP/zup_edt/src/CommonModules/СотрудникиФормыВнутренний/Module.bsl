////////////////////////////////////////////////////////////////////////////////
// СотрудникиФормыВнутренний: методы, обслуживающие работу формы сотрудника.
//  
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

#Область ОбработчикиСобытийФормыСотрудника

Процедура СотрудникиПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	СотрудникиФормыРасширенный.СотрудникиПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура СотрудникиПриЧтенииНаСервере(Форма, ТекущийОбъект) Экспорт
	
	СотрудникиФормыРасширенный.СотрудникиПриЧтенииНаСервере(Форма, ТекущийОбъект);
	
КонецПроцедуры

Процедура СотрудникиПриЗаписиНаСервере(Форма, Отказ, ТекущийОбъект, ПараметрыЗаписи) Экспорт
	
	СотрудникиФормыРасширенный.СотрудникиПриЗаписиНаСервере(Форма, Отказ, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

Процедура СотрудникиОбработкаПроверкиЗаполненияНаСервере(Форма, Отказ, ПроверяемыеРеквизиты) Экспорт
	
	СотрудникиФормыРасширенный.СотрудникиОбработкаПроверкиЗаполненияНаСервере(Форма, Отказ, ПроверяемыеРеквизиты);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийФормыФизическогоЛица

Процедура ФизическиеЛицаПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	СотрудникиФормыРасширенный.ФизическиеЛицаПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ФизическиеЛицаПриЧтенииНаСервере(Форма, ТекущийОбъект) Экспорт
	
	СотрудникиФормыБазовый.ФизическиеЛицаПриЧтенииНаСервере(Форма, ТекущийОбъект);
	
КонецПроцедуры

Процедура ФизическиеЛицаПриЗаписиНаСервере(Форма, Отказ, ТекущийОбъект, ПараметрыЗаписи) Экспорт
	
	СотрудникиФормыРасширенный.ФизическиеЛицаПриЗаписиНаСервере(Форма, Отказ, ТекущийОбъект, ПараметрыЗаписи);	
	
КонецПроцедуры

Процедура ФизическиеЛицаПослеЗаписиНаСервере(Форма, ТекущийОбъект, ПараметрыЗаписи) Экспорт
	
	СотрудникиФормыРасширенный.ФизическиеЛицаПослеЗаписиНаСервере(Форма, ТекущийОбъект, ПараметрыЗаписи);
	
КонецПроцедуры

#КонецОбласти

#Область ПроцедурыДляДополненияФормыМестамиРаботы

Процедура ПроверитьНеобходимостьНастройкиРежимовРаботыФормыСотрудника(Источник, Отказ) Экспорт
	
	СотрудникиФормыРасширенный.ПроверитьНеобходимостьНастройкиРежимовРаботыФормыСотрудника(Источник, Отказ);
	
КонецПроцедуры

Процедура ОбновитьРежимыРаботыФормы() Экспорт
	
	СотрудникиФормыРасширенный.ОбновитьРежимыРаботыФормы();
	
КонецПроцедуры

#КонецОбласти

#Область ПрочиеПроцедурыИФункции

Функция ЗаголовокКнопкиОткрытияСотрудника(ДанныеСотрудника, РеквизитыОрганизации, ДатаСведений, ВыводитьПодробнуюИнформацию) Экспорт
	
	Возврат СотрудникиФормыРасширенный.ЗаголовокКнопкиОткрытияСотрудника(ДанныеСотрудника, РеквизитыОрганизации, ДатаСведений, ВыводитьПодробнуюИнформацию);
	
КонецФункции

Функция ПоясняющаяНадписьКМестуРаботыСотрудника(ДанныеСотрудника, РеквизитыОрганизации, ДатаСведений) Экспорт
	
	Возврат СотрудникиФормыРасширенный.ПоясняющаяНадписьКМестуРаботыСотрудника(ДанныеСотрудника, РеквизитыОрганизации, ДатаСведений);
	
КонецФункции

Процедура УстановитьВидимостьЭлементовФормыМестаРаботы(Форма, НомерСотрудника, ДанныеСотрудника) Экспорт
	
	СотрудникиФормыРасширенный.УстановитьВидимостьЭлементовФормыМестаРаботы(Форма, НомерСотрудника, ДанныеСотрудника);
	
КонецПроцедуры

Функция ДругиеРабочиеМеста(ФизическоеЛицоСсылка, СотрудникИсключение) Экспорт
	
	Возврат СотрудникиФормыРасширенный.ДругиеРабочиеМеста(ФизическоеЛицоСсылка, СотрудникИсключение);
	
КонецФункции

Процедура ЗаполнитьПервоначальныеЗначения(Форма) Экспорт
	
	СотрудникиФормыРасширенный.ЗаполнитьПервоначальныеЗначения(Форма);
	
КонецПроцедуры

Процедура СотрудникиОбновитьЭлементыФормы(Форма) Экспорт
	
	СотрудникиФормыРасширенный.СотрудникиОбновитьЭлементыФормы(Форма);
	
КонецПроцедуры

Процедура ФизическиеЛицаОбновитьЭлементыФормы(Форма) Экспорт
	
	СотрудникиФормыРасширенный.ФизическиеЛицаОбновитьЭлементыФормы(Форма);
	
КонецПроцедуры

Процедура ЛичныеДанныеФизическихЛицОбработкаПроверкиЗаполненияВФорме(Форма, ФизическоеЛицоСсылка, Отказ) Экспорт
	
	СотрудникиФормыРасширенный.ЛичныеДанныеФизическихЛицОбработкаПроверкиЗаполненияВФорме(Форма, ФизическоеЛицоСсылка, Отказ);
	
КонецПроцедуры
	
Процедура ЛичныеДанныеФизическогоЛицаПриЗаписи(Форма, ФизическоеЛицоСсылка, Организация) Экспорт
	
	СотрудникиФормыРасширенный.ЛичныеДанныеФизическогоЛицаПриЗаписи(Форма, ФизическоеЛицоСсылка, Организация);
	
КонецПроцедуры
	
Процедура ПрочитатьДанныеСвязанныеССотрудником(Форма) Экспорт
	
	СотрудникиФормыРасширенный.ПрочитатьДанныеСвязанныеССотрудником(Форма);
	
КонецПроцедуры

Процедура ПрочитатьДанныеСвязанныеСФизлицом(Форма, ДоступенПросмотрДанныхФизическихЛиц, Организация, ИзФормыСотрудника) Экспорт
	
	СотрудникиФормыБазовый.ПрочитатьДанныеСвязанныеСФизлицом(Форма, ДоступенПросмотрДанныхФизическихЛиц, Организация, ИзФормыСотрудника);
	
КонецПроцедуры

Функция КлючиСтруктурыТекущихКадровыхДанныхСотрудника() Экспорт
	
	Возврат СотрудникиФормыРасширенный.КлючиСтруктурыТекущихКадровыхДанныхСотрудника();
	
КонецФункции

Функция КлючиСтруктурыТекущихТарифныхСтавокСотрудника() Экспорт
	
	Возврат СотрудникиФормыРасширенный.КлючиСтруктурыТекущихТарифныхСтавокСотрудника();
	
КонецФункции

Процедура УстановитьОтображениеСпособовРасчетаАванса(Форма) Экспорт
	
	СотрудникиФормыРасширенный.УстановитьОтображениеСпособовРасчетаАванса(Форма);
	
КонецПроцедуры

Процедура ЗаписатьЗначенияПоУмолчанию(ФизическоеЛицоСсылка, ГражданствоПоУмолчанию) Экспорт
	
	СотрудникиФормыРасширенный.ЗаписатьЗначенияПоУмолчанию(ФизическоеЛицоСсылка, ГражданствоПоУмолчанию);
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСДополнительнымиФормами

Процедура СохранитьДанныеДополнительнойФормы(Форма, ИмяФормы, Отказ, ТекущийОбъект) Экспорт
	
	СотрудникиФормыРасширенный.СохранитьДанныеДополнительнойФормы(Форма, ИмяФормы, Отказ, ТекущийОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область ПостроительМеню

Функция ОписаниеМенюВводаНаОсновании(ПараметрыПостроения) Экспорт
	
	Возврат СотрудникиФормыРасширенный.ОписаниеМенюВводаНаОсновании(ПараметрыПостроения);
	
КонецФункции

#КонецОбласти

#Область ИсторияВзаимоотношенийСКомпанией

Процедура ЗаполнитьРолиФизическогоЛицаИсторииВзаимоотношений(Роли) Экспорт
	СотрудникиФормыРасширенный.ЗаполнитьРолиФизическогоЛицаИсторииВзаимоотношений(Роли);
КонецПроцедуры

Процедура ЗаполнитьИсториюВзаимоотношений(История, ФизическиеЛица) Экспорт
	СотрудникиФормыРасширенный.ЗаполнитьИсториюВзаимоотношений(История, ФизическиеЛица);
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("КоличествоСтавок", КоличествоСтавок);
	
	Если КоличествоСтавок = 0 Тогда
		КоличествоСтавок = 1;
		Модифицированность = Истина;
	КонецЕсли;
	
	Если КадровыйУчетРасширенныйКлиентСервер.ПредставлениеРациональногоЧисла(КоличествоСтавок, Числитель, Знаменатель) Тогда
		
		Если Числитель = 1 И Знаменатель = 1 Тогда
			КоличествоСтавокПредопределенное = 1;
		ИначеЕсли Числитель = 1 И Знаменатель = 8 Тогда
			КоличествоСтавокПредопределенное = 2;
		ИначеЕсли Числитель = 1 И Знаменатель = 4 Тогда
			КоличествоСтавокПредопределенное = 3;
		ИначеЕсли Числитель = 1 И Знаменатель = 3 Тогда
			КоличествоСтавокПредопределенное = 4;
		ИначеЕсли Числитель = 1 И Знаменатель = 2 Тогда
			КоличествоСтавокПредопределенное = 5;
		ИначеЕсли Числитель = 2 И Знаменатель = 3 Тогда
			КоличествоСтавокПредопределенное = 6;
		Иначе
			КоличествоСтавокПредопределенное = 0;
		КонецЕсли; 
		
	Иначе
		КоличествоСтавокПредопределенное = -1;
	КонецЕсли;
	
	УстановитьВыбранноеКоличествоСтавок(ЭтаФорма);
	
	Если Не Пользователи.РолиДоступны("ДобавлениеИзменениеКадровогоСостоянияРасширенная,ПолныеПрава", , Ложь) Тогда
		ТолькоПросмотр = Истина;
	КонецЕсли; 
	
	Если ТолькоПросмотр Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ФормаОК",
			"Видимость",
			Ложь);
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ФормаЗакрыть",
			"КнопкаПоУмолчанию",
			Истина);
		
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если Не Модифицированность Тогда
		Возврат;
	КонецЕсли;
		
	ТекстПредупреждения = НСтр("ru = 'Данные были изменены, внесенные изменения будут отменены.
									 |Отменить и закрыть?'");
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияПроизвольнойФормы(ЭтотОбъект, Отказ, ЗавершениеРаботы, ТекстПредупреждения, "ДействиеВыбрано");
		
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КоличествоСтавокПредопределенноеПриИзменении(Элемент)
	
	УстановитьВыбранноеКоличествоСтавок(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура КоличествоСтавокЧислителемИЗнаменателемПриИзменении(Элемент)
	
	УстановитьВыбранноеКоличествоСтавок(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура КоличествоСтавокДесятичнойДробьюПриИзменении(Элемент)
	
	УстановитьВыбранноеКоличествоСтавок(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ЧислительПриИзменении(Элемент)
	
	РассчитатьКоличествоСтавокПоЧислителюИЗнаменателю();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗнаменательПриИзменении(Элемент)
	
	РассчитатьКоличествоСтавокПоЧислителюИЗнаменателю();
	
КонецПроцедуры

&НаКлиенте
Процедура КоличествоСтавокРегулирование(Элемент, Направление, СтандартнаяОбработка)
	
	КадровыйУчетРасширенныйКлиент.КоличествоСтавокРегулирование(ЭтаФорма, КоличествоСтавок, Направление, СтандартнаяОбработка);
	РассчитатьЧислительИЗнаменательКоличестваСтавок();
	
КонецПроцедуры

&НаКлиенте
Процедура КоличествоСтавокПриИзменении(Элемент)
	
	РассчитатьЧислительИЗнаменательКоличестваСтавок();
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОК(Команда)
	
	Если Модифицированность Тогда
		Модифицированность = Ложь;
		Закрыть(КоличествоСтавок);
	Иначе
		Закрыть();
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьКоличествоСтавокПоЧислителюИЗнаменателю()
	
	КоличествоСтавок = КоличествоСтавокПоЧислителюИЗнаменателю(Числитель, Знаменатель);
	ТочностьВПолеВводаКоличестваСтавок = КадровыйУчетРасширенныйКлиентСервер.ТочностьКоличестваСтавок(КоличествоСтавок);
	УстановитьФорматДесятичногоПредставленияКоличестваСтавок(ЭтаФорма, ТочностьВПолеВводаКоличестваСтавок);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция КоличествоСтавокПоЧислителюИЗнаменателю(Числитель, Знаменатель)
	
	Возврат Числитель / ?(Знаменатель = 0, 1, Знаменатель);
	
КонецФункции

&НаКлиенте
Процедура РассчитатьЧислительИЗнаменательКоличестваСтавок()
	
	КадровыйУчетРасширенныйКлиентСервер.ПредставлениеРациональногоЧисла(КоличествоСтавок, Числитель, Знаменатель);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВыбранноеКоличествоСтавок(Форма)
	
	Если Форма.КоличествоСтавокПредопределенное = 1 Тогда
		
		Форма.Числитель = 1;
		Форма.Знаменатель = 1;
		ТочностьВПолеВводаКоличестваСтавок = 0;
		
	ИначеЕсли Форма.КоличествоСтавокПредопределенное = 2 Тогда
		
		Форма.Числитель = 1;
		Форма.Знаменатель = 8;
		ТочностьВПолеВводаКоличестваСтавок = 3;
		
	ИначеЕсли Форма.КоличествоСтавокПредопределенное = 3 Тогда
		
		Форма.Числитель = 1;
		Форма.Знаменатель = 4;
		ТочностьВПолеВводаКоличестваСтавок = 2;
		
	ИначеЕсли Форма.КоличествоСтавокПредопределенное = 4 Тогда
		
		Форма.Числитель = 1;
		Форма.Знаменатель = 3;
		ТочностьВПолеВводаКоличестваСтавок = 20;
		
	ИначеЕсли Форма.КоличествоСтавокПредопределенное = 5 Тогда
		
		Форма.Числитель = 1;
		Форма.Знаменатель = 2;
		ТочностьВПолеВводаКоличестваСтавок = 2;
		
	ИначеЕсли Форма.КоличествоСтавокПредопределенное = 6 Тогда
		
		Форма.Числитель = 2;
		Форма.Знаменатель = 3;
		ТочностьВПолеВводаКоличестваСтавок = 20;
		
	ИначеЕсли Форма.КоличествоСтавокПредопределенное = 0 Тогда
		
		ТочностьВПолеВводаКоличестваСтавок = КадровыйУчетРасширенныйКлиентСервер.ТочностьКоличестваСтавок(Форма.КоличествоСтавок);
		
	ИначеЕсли Форма.КоличествоСтавокПредопределенное <> 0 Тогда
		
		КадровыйУчетРасширенныйКлиентСервер.ПредставлениеРациональногоЧисла(Форма.КоличествоСтавок, Форма.Числитель, Форма.Знаменатель);
		ТочностьВПолеВводаКоличестваСтавок = 20;
		
	КонецЕсли;
	
	Если Форма.КоличествоСтавокПредопределенное >= 0 Тогда
		Форма.КоличествоСтавок = КоличествоСтавокПоЧислителюИЗнаменателю(Форма.Числитель, Форма.Знаменатель);
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ЧислительИЗнаменательГруппа",
		"Доступность",
		Форма.КоличествоСтавокПредопределенное = 0);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"КоличествоСтавок",
		"Доступность",
		Форма.КоличествоСтавокПредопределенное < 0);
		
	УстановитьФорматДесятичногоПредставленияКоличестваСтавок(Форма, ТочностьВПолеВводаКоличестваСтавок);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция УстановитьФорматДесятичногоПредставленияКоличестваСтавок(Форма, ТочностьВПолеВводаКоличестваСтавок)
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"КоличествоСтавок",
		"ФорматРедактирования",
		"ЧДЦ=" + ТочностьВПолеВводаКоличестваСтавок + "");
	
КонецФункции

#КонецОбласти



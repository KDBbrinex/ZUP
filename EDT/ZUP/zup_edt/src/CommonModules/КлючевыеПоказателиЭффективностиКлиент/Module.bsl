#Область СлужебныеПроцедурыИФункции

Процедура ПриИзмененииПризнакаОбратнаяШкала(ШкалаЗначений, ОбратнаяШкала) Экспорт

	ИзменитьЗнакПоследнегоПорогаШкалы(ШкалаЗначений, ОбратнаяШкала);
	КлючевыеПоказателиЭффективностиКлиентСервер.ОтсортироватьШкалуЗначений(ШкалаЗначений, ОбратнаяШкала);
	КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеИнтервалаПоНижнейГранице(ШкалаЗначений, ОбратнаяШкала);

КонецПроцедуры

Процедура ШкалыЗначенийПриНачалеРедактирования(Форма, ТекущиеДанные) Экспорт

	Форма["ШкалаЗначенийЗначениеДоПрежнее"] = ТекущиеДанные.ЗначениеДо;
	ТекущиеДанные.ОтключитьУсловноеОформление = Истина;

КонецПроцедуры

Процедура ШкалаЗначенийПриИзмененииЗначенияШкалы(Форма, Элемент, НоваяСтрока, ОтменаРедактирования, Отказ, СтруктураПараметров) Экспорт

	ТекущиеДанные = Элемент.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущиеДанные.ОтключитьУсловноеОформление = Ложь;
	
	ВернутьЗначениеШкалы = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, "ВернутьЗначениеШкалы");
	ШкалаЗначенийЗначениеДоПрежнее = Форма["ШкалаЗначенийЗначениеДоПрежнее"];
	
	ШкалаЗначений = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(СтруктураПараметров, "ШкалаЗначений");
	ОбратнаяШкала = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(СтруктураПараметров, "ОбратнаяШкала");
	ОтборСтрок = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(СтруктураПараметров, "ОтборСтрок");
	ИмяПоляЗначениеДо =  ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(СтруктураПараметров, "ИмяПоляЗначениеДо");
	ИмяТабличнойЧасти =  ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(СтруктураПараметров, "ИмяТабличнойЧасти");
	
	Если ОтменаРедактирования Тогда
		Если ВернутьЗначениеШкалы Тогда
			Элемент.ТекущиеДанные.ЗначениеДо = ШкалаЗначенийЗначениеДоПрежнее;
			ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(Форма, "ВернутьЗначениеШкалы", Ложь);
		КонецЕсли;
		
		Возврат;
	КонецЕсли;
	
	Если Не НоваяСтрока И ШкалаЗначенийЗначениеДоПрежнее = ТекущиеДанные.ЗначениеДо Тогда
		Возврат;
	КонецЕсли;
	
	КоллекцияСтрокШкалы = КлючевыеПоказателиЭффективностиКлиентСервер.ШкалаПоказателяПоОтбору(ШкалаЗначений, ОтборСтрок);
	КлючевыеПоказателиЭффективностиКлиентСервер.ПроверитьЗаполнениеШкалы(КоллекцияСтрокШкалы, Отказ);
	
	Если Не Отказ Тогда
		КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПозициюЭлементаВКоллекции(
			ШкалаЗначений,
			ОтборСтрок,
			ТекущиеДанные,
			ОбратнаяШкала);
			
		КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеИнтервалаПоНижнейГранице(
			КлючевыеПоказателиЭффективностиКлиентСервер.ШкалаПоказателяПоОтбору(ШкалаЗначений, ОтборСтрок),
			ОбратнаяШкала);
	Иначе
		ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(Форма, "ВернутьЗначениеШкалы", Истина);
		
		ОчиститьСообщения();
		Если НоваяСтрока Тогда
			ИмяПоляФормы = ИмяТабличнойЧасти + СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("[%1]", ШкалаЗначений.Индекс(Элемент.ТекущиеДанные));
		Иначе
			ИмяПоляФормы = ИмяТабличнойЧасти + СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("[%1].ЗначениеДо", ШкалаЗначений.Индекс(Элемент.ТекущиеДанные));
		КонецЕсли;
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Такое пороговое значение уже присутствует в шкале'"),, ИмяПоляФормы);
	КонецЕсли;
	
КонецПроцедуры

Процедура ШкалаЗначенийПередУдалением(Элемент, Отказ, ОбратнаяШкала) Экспорт
	
	ТекущиеДанные = Элемент.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.ЗначениеДо = КлючевыеПоказателиЭффективностиКлиентСервер.ЗначениеПоследнегоПорогаШкалы(ОбратнаяШкала) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

Процедура ШкалаЗначенийПослеУдаления(ШкалаЗначений, ОбратнаяШкала, ОтборСтрок = Неопределено) Экспорт
	
	КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеИнтервалаПоНижнейГранице(
		КлючевыеПоказателиЭффективностиКлиентСервер.ШкалаПоказателяПоОтбору(ШкалаЗначений, ОтборСтрок),
		ОбратнаяШкала);
	
КонецПроцедуры

Процедура УстановитьИнтервалыОценки(ШкалаЗначений, ТекущиеДанные, ОтборСтрок = Неопределено) Экспорт

	Если ОтборСтрок = Неопределено Тогда
		ШкалаПоказателя = ШкалаЗначений;
	Иначе
		ШкалаПоказателя = ШкалаЗначений.НайтиСтроки(Новый Структура(ОтборСтрок));
	КонецЕсли;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ТекущиеДанные.ОценкаЗадаетсяИнтервалом
		ИЛИ ЗначениеЗаполнено(ТекущиеДанные.ИнтервалОценкиОт)
		ИЛИ ЗначениеЗаполнено(ТекущиеДанные.ИнтервалОценкиДо) Тогда
		
		Возврат;
	КонецЕсли;
	
	Если ОтборСтрок = Неопределено Тогда
		ИндексСтроки = ШкалаПоказателя.Индекс(ТекущиеДанные);
	Иначе
		ИндексСтроки = ШкалаПоказателя.Найти(ТекущиеДанные);
	КонецЕсли;
	
	Если ИндексСтроки = 0 Тогда
		ТекущиеДанные.ИнтервалОценкиОт = ТекущиеДанные.ЗначениеДо;
		ТекущиеДанные.ИнтервалОценкиДо = ТекущиеДанные.ЗначениеДо;
	ИначеЕсли ИндексСтроки = ШкалаПоказателя.Количество() - 1 Тогда
		ТекущиеДанные.ИнтервалОценкиОт = ШкалаПоказателя[ИндексСтроки - 1].ЗначениеДо;
		ТекущиеДанные.ИнтервалОценкиДо = ШкалаПоказателя[ИндексСтроки - 1].ЗначениеДо;
	Иначе
		ТекущиеДанные.ИнтервалОценкиОт = ШкалаПоказателя[ИндексСтроки - 1].ЗначениеДо;
		ТекущиеДанные.ИнтервалОценкиДо = ТекущиеДанные.ЗначениеДо;
	КонецЕсли;
	
	КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеИнтервалаОценкиВСтроке(ТекущиеДанные);

КонецПроцедуры

Процедура ПериодСтрокойРегулирование(Форма, Направление, ИмяРеквизитаГоризонт = "Объект.Горизонт", ИмяРеквизитаПериод = "Объект.Период", ИмяРеквизитаПредставления = "ПериодСтрокой") Экспорт

	Горизонт = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ИмяРеквизитаГоризонт);
	Период = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ИмяРеквизитаПериод);
	
	ШагРегулирования = КлючевыеПоказателиЭффективностиКлиентСервер.КоличествоМесяцевГоризонтаОценки(Горизонт);
	Если ШагРегулирования = Неопределено Тогда 
		Возврат;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(
		Форма, ИмяРеквизитаПериод, ДобавитьМесяц(Период, Направление * ШагРегулирования));
		
	КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеПериодаПоДате(
		Форма, ИмяРеквизитаГоризонт, ИмяРеквизитаПериод, ИмяРеквизитаПредставления);
		
	Форма.Модифицированность = Истина;
	
КонецПроцедуры

Процедура ВыбратьПериод(Форма, ОповещениеЗавершения = Неопределено, СтруктураИменРеквизитов = Неопределено) Экспорт
	
	ИменаРеквизитовФормы = Новый Структура;
	Если СтруктураИменРеквизитов = Неопределено Тогда
		ИменаРеквизитовФормы.Вставить("ИмяРеквизитаГоризонт", "Объект.Горизонт");
		ИменаРеквизитовФормы.Вставить("ИмяРеквизитаПериод", "Объект.Период");
		ИменаРеквизитовФормы.Вставить("ИмяРеквизитаПредставленияПериода", "ПериодСтрокой");
	Иначе
		ИменаРеквизитовФормы = ОбщегоНазначенияКлиент.СкопироватьРекурсивно(СтруктураИменРеквизитов);
	КонецЕсли;
	
	МассивВидовПериодов = КлючевыеПоказателиЭффективностиВызовСервера.МассивСтрокВидовПериодов();
	ВыбиратьВидПериода = МассивВидовПериодов.Количество() > 1;
	
	// Дополнительные параметры.
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Форма", Форма);
	ДополнительныеПараметры.Вставить("ИменаРеквизитовФормы", ИменаРеквизитовФормы);
	ДополнительныеПараметры.Вставить("ОповещениеЗавершения", ОповещениеЗавершения);
	ДополнительныеПараметры.Вставить("ВыбиратьВидПериода", ВыбиратьВидПериода);
	
	ОповещениеОЗакрытии = Новый ОписаниеОповещения("ВыбратьПериодЗавершение", ЭтотОбъект, ДополнительныеПараметры);
	
	// Параметры формы.
	Период = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ИменаРеквизитовФормы.ИмяРеквизитаПериод);
	ТекущийГоризонт = ОбщегоНазначенияКлиентСервер.ПолучитьРеквизитФормыПоПути(Форма, ИменаРеквизитовФормы.ИмяРеквизитаГоризонт);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Значение", Период);
	ПараметрыФормы.Вставить("РежимВыбораПериода", КлючевыеПоказателиЭффективностиКлиентСервер.ИмяПериодаПоГоризонту(ТекущийГоризонт));
	ПараметрыФормы.Вставить("ВыбиратьВидПериода", ВыбиратьВидПериода);
	Если ВыбиратьВидПериода Тогда
		ПараметрыФормы.Вставить("ВидыВыбираемыхПериодов", МассивВидовПериодов);
		ПараметрыФормы.Вставить("КлючСохраненияПоложенияОкна", "НесколькоПериодов");
	КонецЕсли;
	
	ОткрытьФорму("ОбщаяФорма.ВыборПериода", ПараметрыФормы, Форма,,,, ОповещениеОЗакрытии, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);

КонецПроцедуры

Процедура ВыбратьПериодЗавершение(Результат, ДополнительныеПараметры) Экспорт

	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Форма = ДополнительныеПараметры.Форма;
	ИменаРеквизитовФормы = ДополнительныеПараметры.ИменаРеквизитовФормы;
	ОповещениеЗавершения = ДополнительныеПараметры.ОповещениеЗавершения;
	ВыбиратьВидПериода = ДополнительныеПараметры.ВыбиратьВидПериода;
	
	Если ВыбиратьВидПериода Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(
			Форма,
			ИменаРеквизитовФормы.ИмяРеквизитаПериод,
			ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(Результат, "Период"));
		ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(
			Форма,
			ИменаРеквизитовФормы.ИмяРеквизитаГоризонт,
			КлючевыеПоказателиЭффективностиКлиентСервер.ГоризонтПоИмениПериода(ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(Результат, "Горизонт")));
	Иначе
		ОбщегоНазначенияКлиентСервер.УстановитьРеквизитФормыПоПути(Форма, ИменаРеквизитовФормы.ИмяРеквизитаПериод, Результат);
	КонецЕсли;
		
	КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеПериодаПоДате(
		Форма, ИменаРеквизитовФормы.ИмяРеквизитаГоризонт, ИменаРеквизитовФормы.ИмяРеквизитаПериод, ИменаРеквизитовФормы.ИмяРеквизитаПредставленияПериода);
	
	Если ОповещениеЗавершения <> Неопределено Тогда
		ВыполнитьОбработкуОповещения(ОповещениеЗавершения);
	КонецЕсли;

КонецПроцедуры

Процедура ИзменитьЗнакПоследнегоПорогаШкалы(ШкалаЗначений, ОбратнаяШкала)

	НайденныеСтроки = ШкалаЗначений.НайтиСтроки(Новый Структура("ЗначениеДо", КлючевыеПоказателиЭффективностиКлиентСервер.ЗначениеПоследнегоПорогаШкалы(Не ОбратнаяШкала)));
	Если НайденныеСтроки.Количество() <> 1 Тогда
		Возврат;
	КонецЕсли;
	
	НайденныеСтроки[0].ЗначениеДо = КлючевыеПоказателиЭффективностиКлиентСервер.ЗначениеПоследнегоПорогаШкалы(ОбратнаяШкала);

КонецПроцедуры

#КонецОбласти


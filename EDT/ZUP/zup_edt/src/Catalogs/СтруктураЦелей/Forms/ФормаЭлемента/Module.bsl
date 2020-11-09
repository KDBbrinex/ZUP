
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Ключ.Пустая() Тогда
		Объект.СпособОценки = ПредопределенноеЗначение("Перечисление.СпособОценкиПоказателяЭффективности.ШкалаЗначений");
		
		ПриПолученииДанныхНаСервере();
	КонецЕсли;
	
	// Обработчик подсистемы "ВерсионированиеОбъектов".
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	ПриПолученииДанныхНаСервере();
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриПолученииДанныхНаСервере();
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если НЕ ПараметрыЗаписи.Свойство("ЗаписатьБезПроверки") Тогда
		ОбработкаПроверкиЗаполненияНаКлиенте(Отказ);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Если ЗакрытьПослеЗаписи Тогда
		Закрыть();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	ЗакрытьПослеЗаписи = Истина;
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	УстановитьКраткоеНаименование();
КонецПроцедуры

&НаКлиенте
Процедура ОписаниеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОбщегоНазначенияКлиент.ПоказатьФормуРедактированияКомментария(
		Элемент.ТекстРедактирования, 
		ЭтаФорма, 
		"Объект.Описание", 
		НСтр("ru = 'Описание показателя'"));
		
КонецПроцедуры

&НаКлиенте
Процедура СпособОценкиПриИзменении(Элемент)
	УстановитьДоступностьЭлементовШкалы(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура СуммируемыйПриИзменении(Элемент)
	Объект.Суммируемый = (СуммируемыйЧисло = 1);
	УстановитьПодсказкуДляСуммируемый(ЭтаФорма);
КонецПроцедуры

&НаКлиенте
Процедура ОбратнаяШкалаПриИзменении(Элемент)
	Объект.ОбратнаяШкала = (ОбратнаяШкалаЧисло = 1);
	ПриИзмененииОбратнаяШкала();
КонецПроцедуры

&НаКлиенте
Процедура ТипГраницШкалПриИзменении(Элемент)
	УстановитьПодсказкуДляТипГраницШкал(ЭтаФорма);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыШкалаЗначений

&НаКлиенте
Процедура ШкалаЗначенийОценкаЗадаетсяИнтерваломПриИзменении(Элемент)
	КлючевыеПоказателиЭффективностиКлиент.УстановитьИнтервалыОценки(Объект.ШкалаЗначений, Элементы.ШкалаЗначений.ТекущиеДанные);
КонецПроцедуры

&НаКлиенте
Процедура ШкалаЗначенийПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если Элемент.ТекущийЭлемент.Имя <> "ШкалаЗначенийЗначениеДо" Тогда
		Возврат;
	КонецЕсли;
	
	КлючевыеПоказателиЭффективностиКлиент.ШкалыЗначенийПриНачалеРедактирования(ЭтаФорма, Элемент.ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ШкалаЗначенийПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	
	СтруктураПараметров = СтруктураПараметровШкалыЗначений();
	КлючевыеПоказателиЭффективностиКлиент.ШкалаЗначенийПриИзмененииЗначенияШкалы(
		ЭтаФорма, Элемент, НоваяСтрока, ОтменаРедактирования, Отказ, СтруктураПараметров);
		
КонецПроцедуры

&НаКлиенте
Процедура ШкалаЗначенийПослеУдаления(Элемент)
	КлючевыеПоказателиЭффективностиКлиент.ШкалаЗначенийПослеУдаления(Объект.ШкалаЗначений, Объект.ОбратнаяШкала);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыШкалаЗначений

&НаКлиенте
Процедура ШкалаЗначенийИнтервалОценкиОтПриИзменении(Элемент)
	КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеИнтервалаОценкиВСтроке(Элементы.ШкалаЗначений.ТекущиеДанные);
КонецПроцедуры

&НаКлиенте
Процедура ШкалаЗначенийИнтервалОценкиДоПриИзменении(Элемент)
	КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеИнтервалаОценкиВСтроке(Элементы.ШкалаЗначений.ТекущиеДанные);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ЗакрытьПослеЗаписи = Истина;
	Записать();
	
КонецПроцедуры

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// СтандартныеПодсистемы.Свойства 
&НаСервере
Процедура ОбновитьЭлементыДополнительныхРеквизитов()
	УправлениеСвойствами.ОбновитьЭлементыДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗависимостиДополнительныхРеквизитов()
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииДополнительногоРеквизита(Элемент)
	УправлениеСвойствамиКлиент.ОбновитьЗависимостиДополнительныхРеквизитов(ЭтотОбъект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура ОбработкаПроверкиЗаполненияНаКлиенте(Отказ)

	Если Не Объект.Суммируемый Тогда
		ПроверитьНаличиеДублейДокументовФакта(Отказ);
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ПриПолученииДанныхНаСервере()

	Если Не ЗначениеЗаполнено(Объект.СпособОценки) Тогда
		
	КонецЕсли;
	
	ЗаполнитьВторичныеРеквизиты();
	
	КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеИнтервалаПоНижнейГранице(Объект.ШкалаЗначений, Объект.ОбратнаяШкала);
	КлючевыеПоказателиЭффективностиКлиентСервер.УстановитьПредставлениеИнтервалаОценки(Объект.ШкалаЗначений);
	
	УстановитьСвойстваЭлементовФормы();

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВторичныеРеквизиты()

	ОбратнаяШкалаЧисло = ?(Объект.ОбратнаяШкала, 1, 0);
	СуммируемыйЧисло = ?(Объект.Суммируемый, 1, 0);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьСвойстваЭлементовФормы()
	
	УсловноеОформление.Элементы.Очистить();
	КлючевыеПоказателиЭффективностиФормы.УстановитьУсловноеОформлениеШкалыЗначений(УсловноеОформление, "ШкалаЗначений");
	
	УстановитьПодсказкуДляСуммируемый(ЭтаФорма);
	УстановитьПодсказкуДляТипГраницШкал(ЭтаФорма);
	
	УстановитьДоступностьЭлементовШкалы(ЭтаФорма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьЭлементовШкалы(Форма);

	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"НастройкиШкалыЗначенийПоказателяГруппа",
		"Доступность",
		Форма.Объект.СпособОценки = ПредопределенноеЗначение("Перечисление.СпособОценкиПоказателяЭффективности.ШкалаЗначений"));

КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииОбратнаяШкала()
	КлючевыеПоказателиЭффективностиКлиент.ПриИзмененииПризнакаОбратнаяШкала(Объект.ШкалаЗначений, Объект.ОбратнаяШкала);
КонецПроцедуры

&НаКлиенте
Процедура УстановитьКраткоеНаименование()

	Если Не ПустаяСтрока(Объект.Наименование)
		И (ПустаяСтрока(Объект.КраткоеНаименование)
		ИЛИ Лев(Объект.Наименование, 30) = Лев(Объект.КраткоеНаименование, 30)) Тогда
		
		Объект.КраткоеНаименование = Объект.Наименование;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Функция СтруктураПараметровШкалыЗначений()

	СтруктураПараметров = Новый Структура;

	СтруктураПараметров.Вставить("ШкалаЗначений", Объект.ШкалаЗначений);
	СтруктураПараметров.Вставить("ОбратнаяШкала", Объект.ОбратнаяШкала);
	СтруктураПараметров.Вставить("ОтборСтрок", Неопределено);
	СтруктураПараметров.Вставить("ИмяПоляЗначениеДо", "ШкалаЗначенийЗначениеДо");
	СтруктураПараметров.Вставить("ИмяТабличнойЧасти", "Объект.ШкалаЗначений");
	
	Возврат СтруктураПараметров;
	
КонецФункции

&НаКлиенте
Процедура ШкалаЗначенийПередУдалением(Элемент, Отказ)
	КлючевыеПоказателиЭффективностиКлиент.ШкалаЗначенийПередУдалением(Элемент, Отказ, Объект.ОбратнаяШкала);
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьПодсказкуДляСуммируемый(Форма);

	Если Форма.Объект.Суммируемый Тогда
		ТекстПодсказки = НСтр("ru = 'Итоговое значение показателя будет получаться как сумма введенных значений.
									|В каждом месяце для сотрудника можно будет ввести несколько документов с разными фактическими значениями показателя.'");
	Иначе
		ТекстПодсказки = НСтр("ru = 'Значения этого показателя не суммируются.
									|В каждом месяце для сотрудника можно будет ввести только один документ с фактическим итоговым значением показателя.'");
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"СуммируемыйРасширеннаяПодсказка",
		"Заголовок",
		ТекстПодсказки);

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьПодсказкуДляТипГраницШкал(Форма)

	Если Форма.Объект.ГраницыШкалы = ПредопределенноеЗначение("Перечисление.ТипыГраницыШкалыПоказателяЭффективности.ФактическоеЗначение") Тогда
		ТекстПодсказки = НСтр("ru = 'Для расчета значения этого показателя ввод плановых значений не требуется.'");
	Иначе
		ТекстПодсказки = НСтр("ru = 'Чтобы рассчитать значение показателя необходимо ввести не только фактическое значение, но и плановое.'");
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ТипГраницШкалРасширеннаяПодсказка",
		"Заголовок",
		ТекстПодсказки);

КонецПроцедуры

&НаКлиенте
Процедура ПроверитьНаличиеДублейДокументовФакта(Отказ)

	Если Объект.Суммируемый = ЗначениеСуммируемыйВБазе() Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЕстьДублиДокументов() Тогда
		Возврат;
	КонецЕсли;
	
	ОбработчикОповещенияОЗакрытии = Новый ОписаниеОповещения("ПроверитьНаличиеДублейДокументовФактаЗавершение", ЭтотОбъект);
	ПоказатьВопрос(
		ОбработчикОповещенияОЗакрытии,
		НСтр("ru = 'Внимание! Уже существуют документы, которые вводили фактическое значение этого показателя несколько раз за месяц.
					|При изменении признака ""Фактическое значение показателя"" перепроведение этих документов будет невозможным.
					|Вы уверены, что хотите изменить этот признак?'"),
		РежимДиалогаВопрос.ДаНет,,
		КодВозвратаДиалога.Да);
	
	Отказ = Истина;
	
КонецПроцедуры

&НаСервере
Функция ЗначениеСуммируемыйВБазе()
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Ссылка, "Суммируемый");
КонецФункции

&НаКлиенте
Процедура ПроверитьНаличиеДублейДокументовФактаЗавершение(Результат, ДополнительныеПараметры) Экспорт

	Если Результат <> КодВозвратаДиалога.Да Тогда
		Объект.Суммируемый = ЗначениеСуммируемыйВБазе();
		СуммируемыйЧисло = ?(Объект.Суммируемый, 1, 0);
		
		Возврат;
	КонецЕсли;
	
	Записать(Новый Структура("ЗаписатьБезПроверки", Истина));

КонецПроцедуры

&НаСервере
Функция ЕстьДублиДокументов()

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	НАЧАЛОПЕРИОДА(ФактическиеЗначенияПоказателейЭффективностиПодразделений.Период, МЕСЯЦ) КАК Месяц,
		|	ФактическиеЗначенияПоказателейЭффективностиПодразделений.Подразделение КАК Подразделение,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ФактическиеЗначенияПоказателейЭффективностиПодразделений.Регистратор) КАК Регистратор
		|ИЗ
		|	РегистрНакопления.ФактическиеЗначенияПоказателейЭффективностиПодразделений КАК ФактическиеЗначенияПоказателейЭффективностиПодразделений
		|ГДЕ
		|	ФактическиеЗначенияПоказателейЭффективностиПодразделений.Показатель = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	НАЧАЛОПЕРИОДА(ФактическиеЗначенияПоказателейЭффективностиПодразделений.Период, МЕСЯЦ),
		|	ФактическиеЗначенияПоказателейЭффективностиПодразделений.Подразделение
		|
		|ИМЕЮЩИЕ
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ФактическиеЗначенияПоказателейЭффективностиПодразделений.Регистратор) > 1
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	НАЧАЛОПЕРИОДА(ФактическиеЗначенияПоказателейЭффективностиСотрудников.Период, МЕСЯЦ) КАК Месяц,
		|	ФактическиеЗначенияПоказателейЭффективностиСотрудников.Сотрудник КАК Сотрудник,
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ФактическиеЗначенияПоказателейЭффективностиСотрудников.Регистратор) КАК Регистратор
		|ИЗ
		|	РегистрНакопления.ФактическиеЗначенияПоказателейЭффективностиСотрудников КАК ФактическиеЗначенияПоказателейЭффективностиСотрудников
		|ГДЕ
		|	ФактическиеЗначенияПоказателейЭффективностиСотрудников.Показатель = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	НАЧАЛОПЕРИОДА(ФактическиеЗначенияПоказателейЭффективностиСотрудников.Период, МЕСЯЦ),
		|	ФактическиеЗначенияПоказателейЭффективностиСотрудников.Сотрудник
		|
		|ИМЕЮЩИЕ
		|	КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ФактическиеЗначенияПоказателейЭффективностиСотрудников.Регистратор) > 1";
	
	Запрос.УстановитьПараметр("Ссылка", Объект.Ссылка);
	
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	
	РезультатЗапросаПодразделения = РезультатыЗапроса[0];
	РезультатЗапросаСотрудники = РезультатыЗапроса[1];
	
	Возврат (Не РезультатЗапросаПодразделения.Пустой()) ИЛИ (Не РезультатЗапросаСотрудники.Пустой());

КонецФункции

#КонецОбласти
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиентСервер.ПриИнициализацииФормыРегламентированногоОтчета(ЭтаФорма, "ПФР");	
	ЭлектронныйДокументооборотСКонтролирующимиОрганами.ОтметитьКакПрочтенное(Объект.Ссылка);
	
	Если Параметры.Ключ.Пустая() Тогда
		ЗарплатаКадры.ЗаполнитьПервоначальныеЗначенияВФорме(ЭтотОбъект, ЗапрашиваемыеЗначенияПервоначальногоЗаполнения());
		НастроитьОтображениеГруппыПодписантов();
	КонецЕсли;
	
	// СтандартныеПодсистемы.ВерсионированиеОбъектов
	ВерсионированиеОбъектов.ПриСозданииНаСервере(ЭтаФорма);
	// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПараметрыРазмещения = ПодключаемыеКоманды.ПараметрыРазмещения();
	ПараметрыРазмещения.КоманднаяПанель = Элементы.ГруппаПечатьПереопределенная;
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект, ПараметрыРазмещения);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ИмяЭлементаДляРазмещения", "ГруппаДополнительныеРеквизиты");
	УправлениеСвойствами.ПриСозданииНаСервере(ЭтотОбъект, ДополнительныеПараметры);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	НастроитьОтображениеГруппыПодписантов();
	ЗаполнитьИнфоНадписиОДокументахУдостоверяющихЛичность(Объект.Сотрудники, Объект.Дата);
	
	ФлагБлокировкиДокумента = Объект.ДокументПринятВПФР;
	
	УстановитьДоступностьДанныхФормы();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ПередЗаписьюНаСервере(ЭтотОбъект, ТекущийОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	УстановитьДоступностьДанныхФормы();
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	Оповестить("Запись_ПачкаДокументовАДВ_1", ПараметрыЗаписи, Объект.Ссылка);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзменениеДанныхФизическогоЛица" Тогда
		СтруктураОтбора = Новый Структура("Сотрудник", Источник);
	
		СтрокиПоСотруднику = Объект.Сотрудники.НайтиСтроки(СтруктураОтбора);
		
		ЗарплатаКадрыКлиентСервер.ОбработкаИзмененияДанныхФизическогоЛица(Объект, Параметр, СтрокиПоСотруднику, Модифицированность);
		КоличествоСтрок = СтрокиПоСотруднику.Количество();
		Если КоличествоСтрок > 0 Тогда
			Элементы.Сотрудники.ТекущаяСтрока = СтрокиПоСотруднику[КоличествоСтрок - 1].ПолучитьИдентификатор();
		КонецЕсли;
		ОтобразитьДанныеФизическогоЛица();
	КонецЕсли;
	
	// СтандартныеПодсистемы.Свойства
	Если УправлениеСвойствамиКлиент.ОбрабатыватьОповещения(ЭтотОбъект, ИмяСобытия, Параметр) Тогда
		ОбновитьЭлементыДополнительныхРеквизитов();
		УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствамиКлиент.ПослеЗагрузкиДополнительныхРеквизитов(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	// СтандартныеПодсистемы.Свойства
	УправлениеСвойствами.ОбработкаПроверкиЗаполнения(ЭтотОбъект, Отказ, ПроверяемыеРеквизиты);
	// Конец СтандартныеПодсистемы.Свойства
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДанныеФизическогоЛицаНажатие(Элемент, СтандартнаяОбработка)
	
	ДанныеТекущейСтроки = Элементы.Сотрудники.ТекущиеДанные;
	СтандартнаяОбработка = Ложь;
	Если ДанныеТекущейСтроки <> Неопределено И ЗначениеЗаполнено(ДанныеТекущейСтроки.Сотрудник) Тогда
		ЗарплатаКадрыКлиент.ОткрытьФормуФизическогоЛицаДляРедактирования(ДанныеТекущейСтроки.Сотрудник, Элемент.Имя);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДанныеСотрудникаНажатие(Элемент, СтандартнаяОбработка)
	
	ДанныеТекущейСтроки = Элементы.Сотрудники.ТекущиеДанные;
	Если ДанныеТекущейСтроки <> Неопределено И ЗначениеЗаполнено(ДанныеТекущейСтроки.Сотрудник) Тогда
		СтандартнаяОбработка = Ложь;
		ПараметрыОткрытия = Новый Структура("Ключ", ДанныеТекущейСтроки.Сотрудник);
		ОткрытьФорму("Справочник.ФизическиеЛица.ФормаОбъекта", ПараметрыОткрытия);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	ОрганизацияПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура РуководительПриИзменении(Элемент)
	
	НастроитьОтображениеГруппыПодписантов();
	
КонецПроцедуры

&НаКлиенте
Процедура ИсполнительПриИзменении(Элемент)
	
	НастроитьОтображениеГруппыПодписантов();
	
КонецПроцедуры

&НаКлиенте
Процедура ФлагБлокировкиДокументаПриИзменении(Элемент)
	ФлагБлокировкиДокументаПриИзмененииНаСервере();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСотрудники

&НаКлиенте
Процедура СотрудникиОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	ОбработкаПодбораНаСервере(ВыбранноеЗначение);
	ОтобразитьДанныеФизическогоЛица();
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникПриИзменении(Элемент)
	
	СтрокаТаблицы = Объект.Сотрудники.НайтиПоИдентификатору(Элементы.Сотрудники.ТекущаяСтрока);
	ДанныеСотрудника = ПолучитьДанныеПоФизЛицуНаСервере(Объект.Дата, СтрокаТаблицы.Сотрудник);
	ЗаполнитьЗначенияСвойств(СтрокаТаблицы, ДанныеСотрудника); 
	ОтобразитьДанныеФизическогоЛица();
	
КонецПроцедуры

&НаКлиенте
Процедура СотрудникиПриАктивизацииСтроки(Элемент)
	
	ДанныеТекущейСтроки = Элементы.Сотрудники.ТекущиеДанные;
	
	Если ДанныеТекущейСтроки = Неопределено Тогда
		ИнфоКартинкаОДокументе = Новый Картинка;
	Иначе
		
		Если ПустаяСтрока(ДанныеТекущейСтроки.ИнфоОДокументеУдостоверяющемЛичностьНадпись) Тогда
			ИнфоКартинкаОДокументе = Новый Картинка;
		Иначе
			ИнфоКартинкаОДокументе = БиблиотекаКартинок.Предупреждение;
		КонецЕсли;
		
	КонецЕсли;
	
	ИнфоОДокументеУдостоверяющемЛичностьКартинка = ИнфоКартинкаОДокументе;
	
	ОтобразитьДанныеФизическогоЛица();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	Оповещение = Новый ОписаниеОповещения("ВыполнитьПодключаемуюКомандуЗавершение", ЭтотОбъект, Команда);
	ПроверитьСЗапросомДальнейшегоДействия(Оповещение);
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПодключаемуюКомандуЗавершение(Результат, Команда) Экспорт
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат) Экспорт
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

// СтандартныеПодсистемы.Свойства
&НаКлиенте
Процедура Подключаемый_СвойстваВыполнитьКоманду(ЭлементИлиКоманда, НавигационнаяСсылка = Неопределено, СтандартнаяОбработка = Неопределено)
	УправлениеСвойствамиКлиент.ВыполнитьКоманду(ЭтотОбъект, ЭлементИлиКоманда, СтандартнаяОбработка);
КонецПроцедуры
// Конец СтандартныеПодсистемы.Свойства

&НаКлиенте
Процедура ЗаписатьНаДиск(Команда)
	Оповещение = Новый ОписаниеОповещения("ЗаписатьНаДискЗавершение", ЭтотОбъект);
	ПроверитьСЗапросомДальнейшегоДействия(Оповещение);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайл(Команда)
	Если Модифицированность Тогда
		Записать();
	КонецЕсли;

	ДанныеФайла = ПолучитьДанныеФайлаНаСервере(Объект.Ссылка, УникальныйИдентификатор);
	Если ДанныеФайла <> Неопределено Тогда
		РаботаСФайламиКлиент.ОткрытьФайл(ДанныеФайла, Ложь);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Подбор(Команда)
	
	НастройкиФормыВыбора = Новый НастройкиКомпоновкиДанных;
	
	ГруппаЭлементовОтбора = ОбщегоНазначенияКлиентСервер.СоздатьГруппуЭлементовОтбора(
		НастройкиФормыВыбора.Отбор.Элементы,
		"СтраховойНомерПФРИЛИ",
		ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли);
	
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(
		ГруппаЭлементовОтбора,
		"СтраховойНомерПФР",
		ВидСравненияКомпоновкиДанных.НеЗаполнено);
									
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(
		ГруппаЭлементовОтбора,
		"СтраховойНомерПФР",
		ВидСравненияКомпоновкиДанных.Равно,
		"   -   -      ");
		
	КадровыйУчетКлиент.ВыбратьФизическихЛицОрганизации(Элементы.Сотрудники, Объект.Организация, Истина, НастройкиФормыВыбора, АдресСпискаПодобранныхСотрудников());
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьДанныеФизическогоЛица(Команда)
	ПерсонифицированныйУчетКлиент.РедактироватьДанныеФизическогоЛица(Элементы.Сотрудники);
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьВКонтролирующийОрган(Команда)
	Оповещение = Новый ОписаниеОповещения("ОтправитьВКонтролирующийОрганЗавершение", ЭтотОбъект);
	ПроверитьСЗапросомДальнейшегоДействия(Оповещение);
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВИнтернете(Команда)
	Если Модифицированность Тогда
		Записать();
	КонецЕсли;

	РегламентированнаяОтчетностьКлиент.ПроверитьВИнтернете(ЭтаФорма, "ПФР");	
КонецПроцедуры

&НаКлиенте
Процедура Проверить(Команда)
	ОчиститьСообщения();

	Отказ = Ложь;
	ПроверкаЗаполненияДокумента(Отказ);
	
	ПроверкаСтороннимиПрограммами(Отказ);
КонецПроцедуры

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

&НаСервере
Процедура УстановитьДоступностьДанныхФормы()
	Если Объект.ДокументПринятВПФР Тогда  
		ТолькоПросмотр = Истина;	
	КонецЕсли;		
КонецПроцедуры

&НаСервере
Процедура ФлагБлокировкиДокументаПриИзмененииНаСервере()
	Модифицированность = Истина;
	Объект.ДокументПринятВПФР = ФлагБлокировкиДокумента;
	Если Не ФлагБлокировкиДокумента Тогда
		ТолькоПросмотр = Ложь;
	КонецЕсли;	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗапрашиваемыеЗначенияПервоначальногоЗаполнения()
	
	ЗапрашиваемыеЗначения = ЗапрашиваемыеЗначенияЗаполненияПоОрганизации();
	ЗапрашиваемыеЗначения.Вставить("Организация", "Объект.Организация");
	ЗапрашиваемыеЗначения.Вставить("Ответственный", "Объект.Ответственный");

	Возврат ЗапрашиваемыеЗначения;
	
КонецФункции

&НаСервереБезКонтекста
Функция ЗапрашиваемыеЗначенияЗаполненияПоОрганизации()
	
	ЗапрашиваемыеЗначения = Новый Структура;
	ЗапрашиваемыеЗначения.Вставить("Руководитель", "Объект.Руководитель");
	ЗапрашиваемыеЗначения.Вставить("ДолжностьРуководителя", "Объект.ДолжностьРуководителя");
	
	Возврат ЗапрашиваемыеЗначения;
	
КонецФункции 

&НаСервере
Процедура ОбработкаПодбораНаСервере(ВыбранныеФизЛица)
	
	СтруктураПоиска = Новый Структура("Сотрудник");
	МассивФизЛицКЗаполнению = Новый Массив;
	
	Для Каждого Сотрудник Из ВыбранныеФизЛица Цикл
		СтруктураПоиска.Сотрудник = Сотрудник;
		Если Объект.Сотрудники.НайтиСтроки(СтруктураПоиска).Количество() = 0 Тогда 
			МассивФизЛицКЗаполнению.Добавить(Сотрудник);	
		КонецЕсли;
	КонецЦикла;	
	
	Если МассивФизЛицКЗаполнению.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ТаблицаСДаннымиСотрудников = Документы.ПачкаДокументовАДВ_1.ПолучитьДанныеПоФизЛицам(МассивФизЛицКЗаполнению, Объект.Дата);
	
	СтрокиПоСотрудникам = Новый Массив;
	ИдентификаторТекущейСтроки = Неопределено;
	Для Каждого СтрокаТаблицаСДаннымиСотрудников Из ТаблицаСДаннымиСотрудников Цикл
		НоваяСтрокаСотрудник = Объект.Сотрудники.Добавить();
		ИдентификаторТекущейСтроки = НоваяСтрокаСотрудник.ПолучитьИдентификатор();	
		ЗаполнитьЗначенияСвойств(НоваяСтрокаСотрудник, СтрокаТаблицаСДаннымиСотрудников);
		СтрокиПоСотрудникам.Добавить(НоваяСтрокаСотрудник);
	КонецЦикла;	
	
	ЗаполнитьИнфоНадписиОДокументахУдостоверяющихЛичность(СтрокиПоСотрудникам, Объект.Дата);
	
	Если ИдентификаторТекущейСтроки <> Неопределено Тогда
		Элементы.Сотрудники.ТекущаяСтрока = ИдентификаторТекущейСтроки;
	КонецЕсли;	
		
КонецПроцедуры	

&НаСервере
Процедура ОбработкаПодбораПоСпискуФизЛицНаСервере(СписокФизЛиц)
	
	ТаблицаСДаннымиФизЛиц = Документы.ПачкаДокументовАДВ_1.ПолучитьДанныеПоФизЛицам(СписокФизЛиц, Объект.Дата);
	
	СтрокиПоСотрудникам = Новый Массив;
	
	Для Каждого СтрокаТаблицаСДаннымиФизЛиц Из ТаблицаСДаннымиФизЛиц Цикл
		НоваяСтрокаСотрудник = Объект.Сотрудники.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрокаСотрудник, СтрокаТаблицаСДаннымиФизЛиц);
		СтрокиПоСотрудникам.Добавить(НоваяСтрокаСотрудник);
	КонецЦикла;	
		
	ЗаполнитьИнфоНадписиОДокументахУдостоверяющихЛичность(СтрокиПоСотрудникам, Объект.Дата);
	
КонецПроцедуры	

&НаСервере
Процедура ОбработатьПодборСпискаСотрудниковНаСервере(АдресФизЛицВХранилище)
	ФизЛицаИзХранилища = ПолучитьИзВременногоХранилища(АдресФизЛицВХранилище);
	МассивФизЛиц = Новый Массив;
		
	Для Каждого СтрокаСотрудник Из Объект.Сотрудники Цикл
		ПереносимаяСтрокаДубль = ФизЛицаИзХранилища.Найти(СтрокаСотрудник.Сотрудник, "Сотрудник");
		Если ПереносимаяСтрокаДубль = Неопределено Тогда
			МассивФизЛиц.Добавить(ФизЛицаИзХранилища.Сотрудник);	
		КонецЕсли;
	КонецЦикла;	
	
	ОбработкаПодбораПоСпискуФизЛицНаСервере(МассивФизЛиц);
КонецПроцедуры	

&НаСервере
Процедура ОрганизацияПриИзмененииНаСервере()
	ПерсонифицированныйУчетФормы.ОрганизацияПриИзменении(ЭтаФорма, ЗапрашиваемыеЗначенияЗаполненияПоОрганизации());	
	ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиентСервер.ПриИнициализацииФормыРегламентированногоОтчета(ЭтаФорма, "ПФР");
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	ОбработатьПодборСпискаСотрудниковНаСервере(ВыбранноеЗначение.АдресФизЛицВХранилище)
КонецПроцедуры

&НаКлиенте
Функция ПолучитьСоответствиеПолейТабличнойЧастиДаннымФормы()
	СтруктураСоответствия = Новый Структура();
	СтруктураСоответствия.Вставить("Фамилия", "Фамилия");
	СтруктураСоответствия.Вставить("Имя", "Имя");
	СтруктураСоответствия.Вставить("Отчество", "Отчество");
	СтруктураСоответствия.Вставить("Пол", "Пол");
	СтруктураСоответствия.Вставить("ДатаРождения", "ДатаРождения");
	СтруктураСоответствия.Вставить("МестоРожденияПредставление", "МестоРожденияПредставление");
	СтруктураСоответствия.Вставить("Гражданство", "Гражданство");
	СтруктураСоответствия.Вставить("АдресФактическийПредставление", "АдресФактическийПредставление");
	СтруктураСоответствия.Вставить("АдресРегистрацииПредставление", "АдресРегистрацииПредставление");
	СтруктураСоответствия.Вставить("Телефоны", "Телефоны");

	Возврат СтруктураСоответствия;
КонецФункции		

&НаКлиенте
Процедура ОтобразитьДанныеФизическогоЛица()
	СтруктураСоответствияПолей = ПолучитьСоответствиеПолейТабличнойЧастиДаннымФормы();
	ДанныеТекущейСтроки = Элементы.Сотрудники.ТекущиеДанные;
	МассивОбязательныхПолей = ПолучитьОбязательныеДляЗаполненияПоля();
	Если ДанныеТекущейСтроки <> Неопределено Тогда
		Для Каждого КлючЗначение Из СтруктураСоответствияПолей Цикл 
			ЗначениеДанныхСтроки = ДанныеТекущейСтроки[КлючЗначение.Ключ];
			ЭлементФормы = Элементы[КлючЗначение.Значение];
			Если Не ЗначениеЗаполнено(ЗначениеДанныхСтроки) И МассивОбязательныхПолей.Найти(КлючЗначение.Значение) <> Неопределено  Тогда
				ЭтаФорма[КлючЗначение.Значение] = НСтр("ru = '<Не заполнено>'");
			Иначе
				Если КлючЗначение.Значение = "ДатаРождения" Тогда
					ЭтаФорма[КлючЗначение.Значение] = ЗначениеДанныхСтроки;	
				Иначе 
					ЭтаФорма[КлючЗначение.Значение] = ВРег(ЗначениеДанныхСтроки);
				КонецЕсли;
			КонецЕсли;	
		КонецЦикла;
		Если Не ЗначениеЗаполнено(ДанныеТекущейСтроки.ВидДокумента) Тогда
			ДокументПредставление = НСтр("ru = '<Не заполнено>'");
		Иначе
			ДокументПредставление = ВРег(ПерсонифицированныйУчетКлиентСервер.ПолучитьПредставлениеДокументаУдостоверяющегоЛичность(ДанныеТекущейСтроки));
		КонецЕсли;
		ДанныеСотрудникаТекст = Строка(ДанныеТекущейСтроки.Сотрудник);	
		Если (НЕ ЗначениеЗаполнено(ДанныеТекущейСтроки.МестоРождения)) Или 
				СокрЛП(СтрЗаменить(ДанныеТекущейСтроки.МестоРождения,",","")) = "" 
				Или СокрЛП(СтрЗаменить(ДанныеТекущейСтроки.МестоРождения,",","")) = "0" Тогда
			МестоРожденияПредставление = НСтр("ru = '<Не заполнено>'");
			НеЗаполненоМестоРождения = Истина;
		Иначе
			НеЗаполненоМестоРождения = Ложь;		
		КонецЕсли;	
			
	Иначе
		Для Каждого КлючЗначение Из СтруктураСоответствияПолей Цикл
			ЭлементФормы = Элементы[КлючЗначение.Значение];	
			ЭтаФорма[КлючЗначение.Значение] = Неопределено;
		КонецЦикла;	
		ДокументПредставление = "";
		ДанныеСотрудникаТекст = "";
		Элементы[СтруктураСоответствияПолей["АдресРегистрацииПредставление"]].Гиперссылка = Ложь;
		Элементы[СтруктураСоответствияПолей["АдресФактическийПредставление"]].Гиперссылка = Ложь;
	КонецЕсли;	
	
КонецПроцедуры	

&НаКлиенте
Процедура ГиперссылкаПоляНадписиАдресаНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	СотрудникиКлиент.ПояснениеНажатие(Элемент);
КонецПроцедуры

&НаКлиенте
Функция ПолучитьОбязательныеДляЗаполненияПоля()
	МассивИменОбязательныхПолей = Новый Массив;
	МассивИменОбязательныхПолей.Добавить("АдресРегистрацииПредставление");
	МассивИменОбязательныхПолей.Добавить("АдресФактическийПредставление");
	МассивИменОбязательныхПолей.Добавить("ДатаРождения");
	МассивИменОбязательныхПолей.Добавить("ДокументПредставление");
	МассивИменОбязательныхПолей.Добавить("Имя");
	МассивИменОбязательныхПолей.Добавить("Пол");
	МассивИменОбязательныхПолей.Добавить("Фамилия");
	
	Возврат МассивИменОбязательныхПолей;
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьДанныеФайлаНаСервере(Ссылка, УникальныйИдентификатор)	
	Возврат ЗарплатаКадры.ПолучитьДанныеФайла(Ссылка, УникальныйИдентификатор);	
КонецФункции	

&НаСервереБезКонтекста
Функция ПолучитьДанныеПоФизЛицуНаСервере(Дата, Сотрудник)
	СтруктураДанныхСотрудника = Новый Структура("Сотрудник, АдресРегистрацииПредставление, АдресФактическийПредставление,
									   |АдресРегистрации, АдресФактический, Телефоны, Фамилия, Имя, Отчество, 
									   |Пол, ДатаРождения, МестоРождения, Гражданство, ВидДокумента, СерияДокумента,
									   |НомерДокумента, ДатаВыдачи, КемВыдан, МестоРожденияПредставление");
	
	ТаблицаСДаннымиСотрудника = Документы.ПачкаДокументовАДВ_1.ПолучитьДанныеПоФизЛицам(Сотрудник, Дата);
	
	Если ТаблицаСДаннымиСотрудника.Количество() > 0 Тогда 
		ЗаполнитьЗначенияСвойств(СтруктураДанныхСотрудника, ТаблицаСДаннымиСотрудника[0]);
	КонецЕсли;	
	
	Возврат СтруктураДанныхСотрудника; 

КонецФункции	

&НаСервереБезКонтекста
Процедура ЗаполнитьИнфоНадписиОДокументахУдостоверяющихЛичность(СтрокиПоСотрудникам, ДатаСведений)
	
	Если ТипЗнч(СтрокиПоСотрудникам) = Тип("ДанныеФормыЭлементКоллекции") Тогда
		МассивСотрудников = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(СтрокиПоСотрудникам.Сотрудник);
		СтрокиПоСотрудникам = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(СтрокиПоСотрудникам);
	ИначеЕсли ТипЗнч(СтрокиПоСотрудникам) = Тип("Массив") Тогда
		МассивСотрудников = Новый Массив;
		Для каждого СтрокаПоСотруднику Из СтрокиПоСотрудникам Цикл
			МассивСотрудников.Добавить(СтрокаПоСотруднику.Сотрудник);
		КонецЦикла;
	Иначе
		МассивСотрудников = СтрокиПоСотрудникам.Выгрузить(, "Сотрудник").ВыгрузитьКолонку("Сотрудник");
	КонецЕсли;
	
	ТекущиеУдостоверенияЛичности = КадровыйУчетФормы.ТекущиеУдостоверенияЛичностиФизическихЛиц(
		МассивСотрудников, ДатаСведений);

	Для каждого СтрокаСотрудника Из СтрокиПоСотрудникам Цикл
		СтрокаСотрудника.ИнфоОДокументеУдостоверяющемЛичностьНадпись = КадровыйУчетФормы.ИнфоНадписьОДокументеУдостоверяющемЛичность(
			ТекущиеУдостоверенияЛичности, СтрокаСотрудника.Сотрудник, СтрокаСотрудника.ВидДокумента, СтрокаСотрудника.СерияДокумента, СтрокаСотрудника.НомерДокумента);
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция АдресСпискаПодобранныхСотрудников()
	
	Возврат ПоместитьВоВременноеХранилище(Объект.Сотрудники.Выгрузить(,"Сотрудник").ВыгрузитьКолонку("Сотрудник"), УникальныйИдентификатор);
	
КонецФункции

&НаСервере
Процедура НастроитьОтображениеГруппыПодписантов()
	ЗарплатаКадры.НастроитьОтображениеГруппыПодписей(Элементы.ПодписиГруппа, "Объект.Руководитель", "Объект.Исполнитель");	
КонецПроцедуры	

&НаСервере
Процедура ПроверкаЗаполненияДокумента(Отказ = Ложь)
	ДокументОбъект = РеквизитФормыВЗначение("Объект");
	
	ДокументОбъект.ПроверитьДанныеДокумента(Отказ);
КонецПроцедуры	

&НаКлиенте
Процедура ПроверкаСтороннимиПрограммами(Отказ)
	
	Если Отказ Тогда
		ТекстВопроса = НСтр("ru = 'При проверке встроенной проверкой обнаружены ошибки.
		|Выполнить проверку сторонними программами?'")
	Иначе	
		ТекстВопроса = НСтр("ru = 'При проверке встроенной проверкой ошибок не обнаружено.
		|Выполнить проверку сторонними программами?'");
	КонецЕсли;
	
	Оповещение = Новый ОписаниеОповещения("ПроверкаСтороннимиПрограммамиЗавершение", ЭтотОбъект);
	ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Да);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверкаСтороннимиПрограммамиЗавершение(Ответ, ДополнительныеПараметры) Экспорт 
	
	Если Ответ = КодВозвратаДиалога.Да Тогда 
		ПроверитьСтороннимиПрограммами();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьСтороннимиПрограммами()
	Если Модифицированность Тогда
		Записать();
	КонецЕсли;

	ПараметрыОткрытия = Новый Структура;
	
	ПроверяемыеОбъекты = Новый Массив;
	ПроверяемыеОбъекты.Добавить(Объект.Ссылка);
	
	ПараметрыОткрытия.Вставить("СсылкиНаПроверяемыеОбъекты", ПроверяемыеОбъекты);
	
	ОткрытьФорму("ОбщаяФорма.ПроверкаФайловОтчетностиПерсУчетаПФР", ПараметрыОткрытия, ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьСЗапросомДальнейшегоДействия(ОповещениеЗавершения = Неопределено)
	ОчиститьСообщения();
	
	Отказ = Ложь;
	ПроверкаЗаполненияДокумента(Отказ);	
	
	ДополнительныеПараметры = Новый Структура("ОповещениеЗавершения", ОповещениеЗавершения);
	
	Если Отказ Тогда 
		ТекстВопроса = НСтр("ru = 'В комплекте обнаружены ошибки.
							|Продолжить (не рекомендуется)?'");
							
		Оповещение = Новый ОписаниеОповещения("ПроверитьСЗапросомДальнейшегоДействияЗавершение", ЭтотОбъект, ДополнительныеПараметры);					
		ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Нет, НСтр("ru = 'Предупреждение.'"));
	Иначе 
		ПроверитьСЗапросомДальнейшегоДействияЗавершение(КодВозвратаДиалога.Да, ДополнительныеПараметры);				
	КонецЕсли;	
	
КонецПроцедуры	

&НаКлиенте
Процедура ПроверитьСЗапросомДальнейшегоДействияЗавершение(Ответ, ДополнительныеПараметры) Экспорт 
	
	Если Ответ <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;			
	
	Если ДополнительныеПараметры.ОповещениеЗавершения <> Неопределено Тогда 
		ВыполнитьОбработкуОповещения(ДополнительныеПараметры.ОповещениеЗавершения);
	КонецЕсли;
	
КонецПроцедуры	

&НаКлиенте
Процедура ЗаписатьНаДискЗавершение(Результат, Параметры) Экспорт
	Если Модифицированность Тогда
		Записать();
	КонецЕсли;

	ДанныеФайла = ПолучитьДанныеФайлаНаСервере(Объект.Ссылка, УникальныйИдентификатор);
	РаботаСФайламиКлиент.СохранитьФайлКак(ДанныеФайла);	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьВКонтролирующийОрганЗавершение(Результат, Параметры) Экспорт
	Если Модифицированность Тогда
		Записать();
	КонецЕсли;

	РегламентированнаяОтчетностьКлиент.ПриНажатииНаКнопкуОтправкиВКонтролирующийОрган(ЭтаФорма, "ПФР");	
КонецПроцедуры

#КонецОбласти

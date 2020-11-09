#Область ОписаниеПеременных

&НаКлиенте
Перем ПараметрыОбработчикаОжидания;

&НаКлиенте
Перем ФормаДлительнойОперации;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ПолучитьНастройкиПрограммы();
	ОбновитьФормуПоНастройкам(ЭтаФорма);
	
	ДоступнаИнтеграцияСВнешнимиРесурсами = ПолучитьФункциональнуюОпцию("ИспользоватьЗарплатаКадрыКорпоративнаяПодсистемы") И ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.РеестрГосслужащих");
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаИнтеграцияСВнешнимиРесурсами", "Видимость", ДоступнаИнтеграцияСВнешнимиРесурсами);
	
	ДоступныВыплатыБывшимВоеннослужащим = ПолучитьФункциональнуюОпцию("ИспользоватьЗарплатаКадрыКорпоративнаяПодсистемы") И ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.ВыплатыБывшимВоеннослужащим");
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, "ГруппаИспользоватьВыплатыБывшимВоеннослужащим", "Видимость", ДоступныВыплатыБывшимВоеннослужащим);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Оповещение = Новый ОписаниеОповещения("ЗаписатьНастройкиНаКлиенте", ЭтотОбъект);
	ОбщегоНазначенияКлиент.ПоказатьПодтверждениеЗакрытияФормы(Оповещение, Отказ, ЗавершениеРаботы);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользоватьВоеннуюСлужбуПриИзменении(Элемент)
	
	Если ИспользоватьВоеннуюСлужбу Тогда
		ВыключитьНастройкиМуниципальнойСлужбы();
		ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВласти = Истина;
	Иначе 
		ВыключитьНастройкиВоеннойСлужбы();
	КонецЕсли;
	ОбновитьФормуПоНастройкам(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВластиПриИзменении(Элемент)
	
	Если НЕ ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВласти Тогда
		РазрешеноСовместительствоВоеннослужащимПоКонтракту = Ложь;
		ВыплачиватьАвансыВоеннослужащимПоКонтракту = Ложь;	
	КонецЕсли;
	
	ОбновитьФормуПоНастройкам(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПриИзменении(Элемент)
	
	Если НЕ ИспользоватьРасчетДенежногоДовольствияВоеннослужащих Тогда
		ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву = Ложь;
	КонецЕсли;
	
	ОбновитьФормуПоНастройкам(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьГосударственнуюСлужбуПриИзменении(Элемент)
	
	Если ИспользоватьГосударственнуюСлужбу Тогда
		ВыключитьНастройкиМуниципальнойСлужбы();
		ПорядокРасчетаОтпусковДолжностейГражданскойСлужбы = 1;
	Иначе
		ВыключитьНастройкиГосударственнойСлужбы();
	КонецЕсли;
	ОбновитьФормуПоНастройкам(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьРасчетДенежногоСодержанияСудейПриИзменении(Элемент)
	
	Если ИспользоватьРасчетДенежногоСодержанияСудей Тогда
		ПорядокРасчетаОтпусковСудей = 2;
	Иначе
		ПорядокРасчетаОтпусковСудей = 0;
	КонецЕсли;
	ОбновитьФормуПоНастройкам(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПорядокРасчетаОтпусковДолжностейГражданскойСлужбыПриИзменении(Элемент)
	
	ОбновитьДоступностьВыбиратьВариантРасчетаСреднего(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПорядокРасчетаОтпусковГосударственныхДолжностейПриИзменении(Элемент)
	
	ОбновитьДоступностьВыбиратьВариантРасчетаСреднего(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПорядокРасчетаОтпусковСудейПриИзменении(Элемент)
	
	ОбновитьДоступностьВыбиратьВариантРасчетаСреднего(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьГосударственныеДолжностиПриИзменении(Элемент)
	
	Если ИспользоватьГосударственныеДолжности Тогда
		ПорядокРасчетаОтпусковГосударственныхДолжностей = 1;
	Иначе
		ПорядокРасчетаОтпусковГосударственныхДолжностей = 0;
		ИспользоватьРасчетДенежногоСодержанияСудей = Ложь;
		ПорядокРасчетаОтпусковСудей = 0;
	КонецЕсли;
	ОбновитьФормуПоНастройкам(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьМуниципальнуюСлужбуПриИзменении(Элемент)
	
	Если ИспользоватьМуниципальнуюСлужбу Тогда
		ВыключитьНастройкиГосударственнойСлужбы();
		ВыключитьНастройкиВоеннойСлужбы();
		ПорядокРасчетаОтпусковДолжностейМуниципальнойСлужбы = 2;
	Иначе	
		ВыключитьНастройкиМуниципальнойСлужбы();
	КонецЕсли;
	ОбновитьФормуПоНастройкам(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьУчетКлассныхЧиновМуниципальныхСлужащихПриИзменении(Элемент)
	
	Если ИспользоватьУчетКлассныхЧиновМуниципальныхСлужащих Тогда
		НачислятьОкладЗаКлассныйЧинМуниципальнымСлужащим = 1;
	Иначе	
		НачислятьОкладЗаКлассныйЧинМуниципальнымСлужащим = 0;
	КонецЕсли;
	ОбновитьФормуПоНастройкам(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьМуниципальныеДолжностиПриИзменении(Элемент)
	
	Если ИспользоватьМуниципальныеДолжности Тогда
		ПорядокРасчетаОтпусковМуниципальныхДолжностей = 2;
	Иначе
		ПорядокРасчетаОтпусковМуниципальныхДолжностей = 0;
	КонецЕсли;
	ОбновитьФормуПоНастройкам(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПорядокРасчетаОтпусковДолжностейМуниципальнойСлужбыПриИзменении(Элемент)
	
	ОбновитьДоступностьВыбиратьВариантРасчетаСреднего(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура ПорядокРасчетаОтпусковМуниципальныхДолжностейПриИзменении(Элемент)
	
	ОбновитьДоступностьВыбиратьВариантРасчетаСреднего(ЭтаФорма);

КонецПроцедуры

&НаКлиенте
Процедура РаботаВМедицинскомУчрежденииПриИзменении(Элемент)
	
	Если Не РаботаВМедицинскомУчреждении Тогда
		ИспользоватьВыгрузкуВФедеральныйРегистрМедицинскихРаботников = Ложь;
		ИспользоватьТарификационнуюОтчетностьУчрежденийФМБА = Ложь;
		ИспользоватьДоступКНаркотическимСредствам = Ложь;
	КонецЕсли;
	ОбновитьФормуПоНастройкам(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура РаботаВОбразовательномУчрежденииПриИзменении(Элемент)
	
	ОбновитьФормуПоНастройкам(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьВыборНачисленияПреподавателей(СписокЭлементов, ЗначениеВыбора)
	
	Для каждого ИдентификаторЗначения Из СписокЭлементов Цикл
		ЭлементСписка = НачисленияПреподавателей.НайтиПоИдентификатору(ИдентификаторЗначения);
		Если ЭлементСписка <> Неопределено Тогда
			ЭлементСписка.Выбрано = ЗначениеВыбора;
		КонецЕсли; 
	КонецЦикла;
	
	Элементы.НачисленияПреподавателей.ОтборСтрок = Новый ФиксированнаяСтруктура("Выбрано", Ложь);
	Элементы.НачисленияПреподавателейВыбранные.ОтборСтрок = Новый ФиксированнаяСтруктура("Выбрано", Истина);
	
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьНастройки(Команда)
	
	ЗаписатьНастройкиНаКлиенте();
	
КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	Модифицированность = Ложь;
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура НачисленияПреподавателейОтменить(Команда)
	
	Если Элементы.НачисленияПреподавателейВыбранные.ВыделенныеСтроки.Количество() > 0 Тогда
		УстановитьВыборНачисленияПреподавателей(Элементы.НачисленияПреподавателейВыбранные.ВыделенныеСтроки, Ложь);
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура НачисленияПреподавателейВыбрать(Команда)
	
	Если Элементы.НачисленияПреподавателей.ВыделенныеСтроки.Количество() > 0 Тогда
		УстановитьВыборНачисленияПреподавателей(Элементы.НачисленияПреподавателей.ВыделенныеСтроки, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОсобенностиПредприятия(Команда)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыОтбора = Новый Структура;
	ПараметрыОтбора.Вставить("ПолеСортировкиРазделов", 2); 
	ПараметрыФормы.Вставить("СформироватьПриОткрытии", Истина);
	ПараметрыФормы.Вставить("Отбор", ПараметрыОтбора);
	ПараметрыФормы.Вставить("КлючВарианта", "НастройкиПоРазделам");
	
	ОткрытьФорму("Отчет.НастройкиПрограммыЗарплатаКадры.Форма", ПараметрыФормы, ЭтотОбъект, Истина);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВыключитьНастройкиМуниципальнойСлужбы()

	ИспользоватьМуниципальнуюСлужбу = Ложь;
	ИспользоватьУчетКлассныхЧиновМуниципальныхСлужащих = Ложь;
	НачислятьОкладЗаКлассныйЧинМуниципальнымСлужащим = 0;
	ПорядокРасчетаОтпусковДолжностейМуниципальнойСлужбы = 0;
	ПорядокРасчетаОтпусковМуниципальныхДолжностей = 0;
	ИспользоватьМуниципальныеДолжности = Ложь;
	ВыбиратьВариантРасчетаСреднегоМуниципальныхСлужащих = Ложь;

КонецПроцедуры

&НаКлиенте
Процедура ВыключитьНастройкиГосударственнойСлужбы()

	ИспользоватьГосударственнуюСлужбу = Ложь;
	ПорядокРасчетаОтпусковДолжностейГражданскойСлужбы = 0;
	ИспользоватьРасчетДенежногоСодержанияСудей = Ложь;
	ПорядокРасчетаОтпусковСудей = 0;
	ИспользоватьГосударственныеДолжности = Ложь;
	ПорядокРасчетаОтпусковГосударственныхДолжностей = 0;
	ИспользоватьРасчетДенежногоСодержанияПрокуроров = Ложь;
	ВыбиратьВариантРасчетаСреднегоГосслужащих = Ложь;
	ИспользоватьВыгрузкуВРеестрГосслужащих = Ложь;

КонецПроцедуры

&НаКлиенте
Процедура ВыключитьНастройкиВоеннойСлужбы()

	ИспользоватьВоеннуюСлужбу = Ложь;
	РасчетДенежногоДовольствияВоеннослужащих = 0;
	ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВласти = Ложь;
	ИспользоватьРасчетДенежногоДовольствияВоеннослужащих = Ложь;
	ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву = Ложь;
	ПремияЗаДВСОРассчитываетсяПоОкладуНаНачалоМесяца = Ложь;
	РазрешеноСовместительствоВоеннослужащимПоКонтракту = Ложь;
	ВыплачиватьАвансыВоеннослужащимПоКонтракту = Ложь;
	ИспользоватьВыплатыБывшимВоеннослужащим = Ложь;

КонецПроцедуры


&НаСервереБезКонтекста
Функция НастройкиМожноЗаписать(НастройкиФормы)
	
	НастройкиПрограммы = ЗарплатаКадрыРасширенный.НастройкиПрограммыБюджетногоУчреждения();
	
	ВыключенУчетВоенныхПоКонтракту = НастройкиПрограммы.ИспользоватьВоеннуюСлужбу И НастройкиФормы.ИспользоватьВоеннуюСлужбу <> НастройкиПрограммы.ИспользоватьВоеннуюСлужбу;
	ВыключенУчетВоенныхПоПризыву   = НастройкиПрограммы.ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву И НастройкиФормы.ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву <> НастройкиПрограммы.ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву;
	ВыключенУчетГосслужащих = НастройкиПрограммы.ИспользоватьГосударственнуюСлужбу И НастройкиФормы.ИспользоватьГосударственнуюСлужбу <> НастройкиПрограммы.ИспользоватьГосударственнуюСлужбу;
	ВыключенУчетМуниципальныхСлужащих =  НастройкиПрограммы.ИспользоватьМуниципальнуюСлужбу И НастройкиФормы.ИспользоватьМуниципальнуюСлужбу <> НастройкиПрограммы.ИспользоватьМуниципальнуюСлужбу;
	
	Если Не ВыключенУчетГосслужащих И Не ВыключенУчетМуниципальныхСлужащих И Не ВыключенУчетВоенныхПоКонтракту Тогда
		Возврат Истина;
	КонецЕсли;
	
	ВидыДоговоров = Новый Массив;
	Если ВыключенУчетВоенныхПоКонтракту Тогда
		ВидыДоговоров.Добавить(Перечисления.ВидыДоговоровССотрудниками.КонтрактВоеннослужащего);
	КонецЕсли;
	Если ВыключенУчетВоенныхПоПризыву Тогда
		ВидыДоговоров.Добавить(Перечисления.ВидыДоговоровССотрудниками.ВоеннослужащийПоПризыву);
	КонецЕсли;
	Если ВыключенУчетГосслужащих Тогда
		ВидыДоговоров.Добавить(Перечисления.ВидыДоговоровССотрудниками.КонтрактГосслужащего);
	КонецЕсли;
	Если ВыключенУчетМуниципальныхСлужащих Тогда
		ВидыДоговоров.Добавить(Перечисления.ВидыДоговоровССотрудниками.ДоговорМуниципальногоСлужащего);
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ВидыДоговоров", ВидыДоговоров);
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	КадроваяИсторияСотрудников.ВидДоговора
	|ИЗ
	|	РегистрСведений.КадроваяИсторияСотрудников КАК КадроваяИсторияСотрудников
	|ГДЕ
	|	КадроваяИсторияСотрудников.ВидДоговора В(&ВидыДоговоров)";
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Истина;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	ТекстСообщения = "";
	Пока Выборка.Следующий() Цикл
		
		Если Выборка.ВидДоговора = Перечисления.ВидыДоговоровССотрудниками.КонтрактГосслужащего Тогда
			ТекстСообщения = ТекстСообщения + ?(ПустаяСтрока(ТекстСообщения),"",Символы.ПС) + НСтр("ru = 'Невозможно отказаться от расчета денежного содержания государственных гражданских служащих.
					|В информационной базе есть сотрудники - государственные гражданские служащие.'")
		ИначеЕсли Выборка.ВидДоговора = Перечисления.ВидыДоговоровССотрудниками.ДоговорМуниципальногоСлужащего Тогда
			ТекстСообщения = ТекстСообщения + ?(ПустаяСтрока(ТекстСообщения),"",Символы.ПС) + НСтр("ru = 'Невозможно отказаться от расчета денежного содержания муниципальных служащих.
					|В информационной базе есть сотрудники - муниципальные служащие.'");
		ИначеЕсли Выборка.ВидДоговора = Перечисления.ВидыДоговоровССотрудниками.КонтрактВоеннослужащего Тогда
			ТекстСообщения = ТекстСообщения + ?(ПустаяСтрока(ТекстСообщения),"",Символы.ПС) + НСтр("ru = 'Невозможно отказаться от расчета денежного довольствия.
					|В информационной базе есть сотрудники - военнослужащие.'");
		ИначеЕсли Выборка.ВидДоговора = Перечисления.ВидыДоговоровССотрудниками.ВоеннослужащийПоПризыву Тогда
			ТекстСообщения = ТекстСообщения + ?(ПустаяСтрока(ТекстСообщения),"",Символы.ПС) + НСтр("ru = 'Невозможно отказаться от расчета денежного довольствия военнослужащих по призыву.
					|В информационной базе есть сотрудники - военнослужащие по призыву.'");
		КонецЕсли;
		
	КонецЦикла;
	
	НастройкиФормы.СообщениеОбОшибкахНастроек = ТекстСообщения;
	
	Возврат Ложь;
	
КонецФункции

&НаСервере
Процедура ПолучитьНастройкиПрограммы()
	
	НастройкиПрограммы = ЗарплатаКадрыРасширенный.НастройкиПрограммыБюджетногоУчреждения();
	ИспользоватьГосударственнуюСлужбу = НастройкиПрограммы.ИспользоватьГосударственнуюСлужбу;
	ИспользоватьМуниципальнуюСлужбу   = НастройкиПрограммы.ИспользоватьМуниципальнуюСлужбу;
	ИспользоватьРасчетДенежногоСодержанияПрокуроров = НастройкиПрограммы.ИспользоватьРасчетДенежногоСодержанияПрокуроров;
	
	НастройкиГосударственнойСлужбы = Новый Структура;
	НастройкиГосударственнойСлужбы.Вставить("ИспользоватьГосударственныеМуниципальныеДолжности", Ложь);
	НастройкиГосударственнойСлужбы.Вставить("ИспользоватьРасчетДенежногоСодержанияСудей", Ложь);
	НастройкиГосударственнойСлужбы.Вставить("ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГражданскойСлужбы", Ложь);
	НастройкиГосударственнойСлужбы.Вставить("ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГосударственнойСлужбы", Ложь);
	НастройкиГосударственнойСлужбы.Вставить("ИспользоватьСохраняемоеДенежноеСодержаниеСудей", Ложь);
	НастройкиГосударственнойСлужбы.Вставить("ВыбиратьВариантРасчетаСреднего", Ложь);
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ГосударственнаяСлужба") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("ГосударственнаяСлужба");
		ЗаполнитьЗначенияСвойств(НастройкиГосударственнойСлужбы, Модуль.НастройкиГосударственнойСлужбы());
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.РеестрГосслужащих") Тогда
		Модуль = ОбщегоНазначения.ОбщийМодуль("РеестрГосслужащих");
		ИспользоватьВыгрузкуВРеестрГосслужащих = Модуль.ИспользоватьВыгрузкуВРеестрГосслужащих();	
	КонецЕсли;
	
	Если ИспользоватьГосударственнуюСлужбу Тогда
		
		ИспользоватьГосударственныеДолжности = НастройкиГосударственнойСлужбы.ИспользоватьГосударственныеМуниципальныеДолжности;
		ИспользоватьРасчетДенежногоСодержанияСудей = НастройкиГосударственнойСлужбы.ИспользоватьРасчетДенежногоСодержанияСудей;
		ВыбиратьВариантРасчетаСреднегоГосслужащих = НастройкиГосударственнойСлужбы.ВыбиратьВариантРасчетаСреднего;
		
		ПорядокРасчетаОтпусковДолжностейГражданскойСлужбы = ?(НастройкиГосударственнойСлужбы.ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГражданскойСлужбы,1,2);
		ПорядокРасчетаОтпусковГосударственныхДолжностей   = ?(ИспользоватьГосударственныеДолжности,?(НастройкиГосударственнойСлужбы.ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГосударственнойСлужбы,1,2),0);
		ПорядокРасчетаОтпусковСудей = ?(ИспользоватьРасчетДенежногоСодержанияСудей,?(НастройкиГосударственнойСлужбы.ИспользоватьСохраняемоеДенежноеСодержаниеСудей,1,2),0);
		
	ИначеЕсли ИспользоватьМуниципальнуюСлужбу Тогда
		
		ИспользоватьМуниципальныеДолжности = НастройкиГосударственнойСлужбы.ИспользоватьГосударственныеМуниципальныеДолжности;
		ВыбиратьВариантРасчетаСреднегоМуниципальныхСлужащих = НастройкиГосударственнойСлужбы.ВыбиратьВариантРасчетаСреднего;
		
		ИспользоватьУчетКлассныхЧиновМуниципальныхСлужащих  = НастройкиПрограммы.ИспользоватьУчетКлассныхЧинов;
		НачислятьОкладЗаКлассныйЧинМуниципальнымСлужащим    = ?(НастройкиПрограммы.НачислятьОкладЗаКлассныйЧинМуниципальнымСлужащим,2,1);
		ПорядокРасчетаОтпусковДолжностейМуниципальнойСлужбы = ?(НастройкиГосударственнойСлужбы.ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГражданскойСлужбы,1,2);
		ПорядокРасчетаОтпусковМуниципальныхДолжностей       = ?(ИспользоватьМуниципальныеДолжности,?(НастройкиГосударственнойСлужбы.ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГосударственнойСлужбы,1,2),0);
		
	КонецЕсли;
	
	ИспользоватьВоеннуюСлужбу 									  = НастройкиПрограммы.ИспользоватьВоеннуюСлужбу;
	ИспользоватьРасчетДенежногоДовольствияВоеннослужащих          = НастройкиПрограммы.ИспользоватьРасчетДенежногоДовольствияВоеннослужащих;
	ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВласти          = НастройкиПрограммы.ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВласти;
	ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву = НастройкиПрограммы.ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву;
	РазрешеноСовместительствоВоеннослужащимПоКонтракту			  = НастройкиПрограммы.РазрешеноСовместительствоВоеннослужащимПоКонтракту;
	ВыплачиватьАвансыВоеннослужащимПоКонтракту			  		  = НастройкиПрограммы.ВыплачиватьАвансыВоеннослужащимПоКонтракту;	
	
	ПремияЗаДВСОРассчитываетсяПоОкладуНаНачалоМесяца = НастройкиПрограммы.ПремияЗаДВСОРассчитываетсяПоОкладуНаНачалоМесяца;
	ИспользоватьВыплатыБывшимВоеннослужащим = НастройкиПрограммы.ИспользоватьВыплатыБывшимВоеннослужащим;
	
	РаботаВМедицинскомУчреждении                                 = НастройкиПрограммы.РаботаВМедицинскомУчреждении;
	ИспользоватьВыгрузкуВФедеральныйРегистрМедицинскихРаботников = НастройкиПрограммы.ИспользоватьВыгрузкуВФедеральныйРегистрМедицинскихРаботников;
	ИспользоватьТарификационнуюОтчетностьУчрежденийФМБА          = НастройкиПрограммы.ИспользоватьТарификационнуюОтчетностьУчрежденийФМБА;
	ИспользоватьДоступКНаркотическимСредствам                    = НастройкиПрограммы.ИспользоватьДоступКНаркотическимСредствам;
	
	РаботаВОбразовательномУчреждении                             = НастройкиПрограммы.РаботаВОбразовательномУчреждении;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.ОбразовательныеУчреждения") Тогда
		
		Модуль = ОбщегоНазначения.ОбщийМодуль("ОбразовательныеУчреждения");
		НачисленияПреподавателей.Загрузить(Модуль.НачисленияРаспределенияНагрузки());
		
	КонецЕсли;
	
	Элементы.НачисленияПреподавателей.ОтборСтрок = Новый ФиксированнаяСтруктура("Выбрано", Ложь);
	Элементы.НачисленияПреподавателейВыбранные.ОтборСтрок = Новый ФиксированнаяСтруктура("Выбрано", Истина);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьФормуПоНастройкам(Форма)
	
	Элементы = Форма.Элементы;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВласти", "Доступность", Форма.ИспользоватьВоеннуюСлужбу);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ИспользоватьРасчетДенежногоДовольствияВоеннослужащих", "Доступность", Форма.ИспользоватьВоеннуюСлужбу);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"СреднемесячноеКоличествоДнейВоеннослужащихИстория", "Доступность", Форма.ИспользоватьВоеннуюСлужбу);
	//	
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву", "Доступность", Форма.ИспользоватьВоеннуюСлужбу И Форма.ИспользоватьРасчетДенежногоДовольствияВоеннослужащих);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"РазрешеноСовместительствоВоеннослужащимПоКонтракту", "Доступность", Форма.ИспользоватьВоеннуюСлужбу И Форма.ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВласти);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ВыплачиватьАвансыВоеннослужащимПоКонтракту", "Доступность", Форма.ИспользоватьВоеннуюСлужбу И Форма.ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВласти);	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ПремияЗаДВСОРассчитываетсяПоОкладуНаНачалоМесяца", "Доступность", Форма.ИспользоватьВоеннуюСлужбу);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ИспользоватьВыплатыБывшимВоеннослужащим", "Доступность", Форма.ИспользоватьВоеннуюСлужбу);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаНастройкиГражданскихСлужащих", "Доступность", Форма.ИспользоватьГосударственнуюСлужбу);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаГосударственныеДолжности", "Доступность", Форма.ИспользоватьГосударственнуюСлужбу);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаПрокурорыСледователи", "Доступность", Форма.ИспользоватьГосударственнуюСлужбу);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаСудьиНастройки", "Доступность", Форма.ИспользоватьГосударственныеДолжности);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ПорядокРасчетаОтпусковГосударственныхДолжностей", "Доступность", Форма.ИспользоватьГосударственныеДолжности);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ПорядокРасчетаОтпусковСудей", "Доступность", Форма.ИспользоватьРасчетДенежногоСодержанияСудей);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаИнтеграцияСВнешнимиРесурсами", "Доступность", Форма.ИспользоватьГосударственнуюСлужбу);
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаНастройкиМуниципальныхСлужащих", "Доступность", Форма.ИспользоватьМуниципальнуюСлужбу);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаНастройкиМуниципальныхДолжностей", "Доступность", Форма.ИспользоватьМуниципальнуюСлужбу);	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаНастройкиКлассныхЧинов", "Доступность", Форма.ИспользоватьМуниципальнуюСлужбу);
		
	Если Форма.ИспользоватьМуниципальнуюСлужбу Тогда
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
			"НачислятьОкладЗаКлассныйЧинМуниципальнымСлужащим", "Доступность", Форма.ИспользоватьУчетКлассныхЧиновМуниципальныхСлужащих);
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
			"ПорядокРасчетаОтпусковМуниципальныхДолжностей", "Доступность", Форма.ИспользоватьМуниципальныеДолжности);	
	КонецЕсли;	
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ИспользоватьВыгрузкуВФедеральныйРегистрМедицинскихРаботников", "Доступность", Форма.РаботаВМедицинскомУчреждении);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ИспользоватьТарификационнуюОтчетностьУчрежденийФМБА", "Доступность", Форма.РаботаВМедицинскомУчреждении);
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ИспользоватьДоступКНаркотическимСредствам", "Доступность", Форма.РаботаВМедицинскомУчреждении);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаОплатаТрудаПреподавателейНастройки", "Доступность", Форма.РаботаВОбразовательномУчреждении);
	
	ОбновитьДоступностьВыбиратьВариантРасчетаСреднего(Форма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьДоступностьВыбиратьВариантРасчетаСреднего(Форма)
	
	Элементы = Форма.Элементы;
	
	ИспользоватьРасчетСохраняемогоДенежногоСодержанияГС = Форма.ИспользоватьГосударственнуюСлужбу И
														((Форма.ПорядокРасчетаОтпусковДолжностейГражданскойСлужбы = 1)
														Или (Форма.ПорядокРасчетаОтпусковГосударственныхДолжностей = 1)
														Или (Форма.ПорядокРасчетаОтпусковСудей = 1));
														
	ИспользоватьРасчетСохраняемогоДенежногоСодержанияМС = Форма.ИспользоватьМуниципальнуюСлужбу И
														((Форма.ПорядокРасчетаОтпусковДолжностейМуниципальнойСлужбы = 1)
														Или (Форма.ПорядокРасчетаОтпусковМуниципальныхДолжностей = 1));
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ВыбиратьВариантРасчетаСреднегоГосслужащих", "Доступность", ИспользоватьРасчетСохраняемогоДенежногоСодержанияГС);
	Если Не ИспользоватьРасчетСохраняемогоДенежногоСодержанияГС И Форма.ВыбиратьВариантРасчетаСреднегоГосслужащих Тогда
		Форма.ВыбиратьВариантРасчетаСреднегоГосслужащих = Ложь;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ВыбиратьВариантРасчетаСреднегоМуниципальныхСлужащих", "Доступность", ИспользоватьРасчетСохраняемогоДенежногоСодержанияМС);
	Если Не ИспользоватьРасчетСохраняемогоДенежногоСодержанияМС И Форма.ВыбиратьВариантРасчетаСреднегоМуниципальныхСлужащих Тогда
		Форма.ВыбиратьВариантРасчетаСреднегоМуниципальныхСлужащих = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЗаписатьНастройкиНаСервере()
	
	СтрокаПараметров = "СоздатьПВР,НастройкиГосслужбы,НастройкиМедицинскогоУчреждения,НастройкиОбразовательногоУчреждения";
	ПараметрыНастроек = Обработки.ПанельНастроекЗарплатаКадры.ЗаполнитьСтруктуруПараметровНастроек(СтрокаПараметров);
	
	Если ИспользоватьГосударственнуюСлужбу Тогда
		ИспользоватьУчетКлассныхЧинов = Истина;
		ИспользоватьГосударственныеМуниципальныеДолжности = ИспользоватьГосударственныеДолжности;
		ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГражданскойСлужбы = (ПорядокРасчетаОтпусковДолжностейГражданскойСлужбы = 1);
		ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГосударственнойСлужбы = (ПорядокРасчетаОтпусковГосударственныхДолжностей = 1);
		ИспользоватьСохраняемоеДенежноеСодержаниеСудей = (ПорядокРасчетаОтпусковСудей = 1);
		ВыбиратьВариантРасчетаСреднего = ВыбиратьВариантРасчетаСреднегоГосслужащих;
	ИначеЕсли ИспользоватьМуниципальнуюСлужбу Тогда
		ИспользоватьУчетКлассныхЧинов = ИспользоватьУчетКлассныхЧиновМуниципальныхСлужащих;
		ИспользоватьГосударственныеМуниципальныеДолжности = ИспользоватьМуниципальныеДолжности;
		ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГражданскойСлужбы = (ПорядокРасчетаОтпусковДолжностейМуниципальнойСлужбы = 1);
		ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГосударственнойСлужбы = (ПорядокРасчетаОтпусковМуниципальныхДолжностей = 1);
		ИспользоватьСохраняемоеДенежноеСодержаниеСудей = Ложь;
		ВыбиратьВариантРасчетаСреднего = ВыбиратьВариантРасчетаСреднегоМуниципальныхСлужащих;
	Иначе
		ИспользоватьУчетКлассныхЧинов = Ложь;
		ИспользоватьГосударственныеМуниципальныеДолжности = Ложь;
		ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГражданскойСлужбы = Ложь;
		ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГосударственнойСлужбы = Ложь;
		ИспользоватьСохраняемоеДенежноеСодержаниеСудей = Ложь;
		ВыбиратьВариантРасчетаСреднего = Ложь;
	КонецЕсли;
	
	ИспользоватьВыгрузкуВРеестрГосслужащих = ?(ИспользоватьГосударственнуюСлужбу,ИспользоватьВыгрузкуВРеестрГосслужащих,Ложь);
	
	ИспользоватьРасчетСохраняемогоДенежногоСодержания = ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГражданскойСлужбы
														Или ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГосударственнойСлужбы
														Или ИспользоватьСохраняемоеДенежноеСодержаниеСудей;
														
	ВыбиратьВариантРасчетаСреднего = ВыбиратьВариантРасчетаСреднего И ИспользоватьРасчетСохраняемогоДенежногоСодержания;
	
	ИспользоватьВоеннуюСлужбу = ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВласти Или ИспользоватьРасчетДенежногоДовольствияВоеннослужащих;
	ПремияЗаДВСОРассчитываетсяПоОкладуНаНачалоМесяца = ?(ИспользоватьВоеннуюСлужбу,ПремияЗаДВСОРассчитываетсяПоОкладуНаНачалоМесяца,Ложь);
	ИспользоватьВыплатыБывшимВоеннослужащим = ?(ИспользоватьВоеннуюСлужбу,ИспользоватьВыплатыБывшимВоеннослужащим,Ложь);
	
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьВоеннуюСлужбу = ИспользоватьВоеннуюСлужбу;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьРасчетДенежногоДовольствияВоеннослужащих = ИспользоватьРасчетДенежногоДовольствияВоеннослужащих;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВласти = ИспользоватьРасчетДенежногоДовольствияСотрудниковОргановИсполнительнойВласти;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву = ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву;
	ПараметрыНастроек.НастройкиГосслужбы.РазрешеноСовместительствоВоеннослужащимПоКонтракту = РазрешеноСовместительствоВоеннослужащимПоКонтракту;
	ПараметрыНастроек.НастройкиГосслужбы.ВыплачиватьАвансыВоеннослужащимПоКонтракту = ВыплачиватьАвансыВоеннослужащимПоКонтракту;	
	ПараметрыНастроек.НастройкиГосслужбы.ПремияЗаДВСОРассчитываетсяПоОкладуНаНачалоМесяца = ПремияЗаДВСОРассчитываетсяПоОкладуНаНачалоМесяца;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьВыплатыБывшимВоеннослужащим = ИспользоватьВыплатыБывшимВоеннослужащим;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьГосударственнуюСлужбу = ИспользоватьГосударственнуюСлужбу;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьМуниципальнуюСлужбу   = ИспользоватьМуниципальнуюСлужбу;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьУчетКлассныхЧинов     = ИспользоватьУчетКлассныхЧинов;
	ПараметрыНастроек.НастройкиГосслужбы.НачислятьОкладЗаКлассныйЧинМуниципальнымСлужащим  = (НачислятьОкладЗаКлассныйЧинМуниципальнымСлужащим = 2);
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьРасчетДенежногоСодержанияПрокуроров   = ИспользоватьРасчетДенежногоСодержанияПрокуроров;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьГосударственныеМуниципальныеДолжности = ИспользоватьГосударственныеМуниципальныеДолжности;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьРасчетДенежногоСодержанияСудей 	   = ИспользоватьРасчетДенежногоСодержанияСудей;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГражданскойСлужбы = ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГражданскойСлужбы;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГосударственнойСлужбы = ИспользоватьСохраняемоеДенежноеСодержаниеДолжностейГосударственнойСлужбы;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьСохраняемоеДенежноеСодержаниеСудей = ИспользоватьСохраняемоеДенежноеСодержаниеСудей;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьРасчетСохраняемогоДенежногоСодержания = ИспользоватьРасчетСохраняемогоДенежногоСодержания;
	ПараметрыНастроек.НастройкиГосслужбы.ВыбиратьВариантРасчетаСреднего = ВыбиратьВариантРасчетаСреднего;
	ПараметрыНастроек.НастройкиГосслужбы.ИспользоватьВыгрузкуВРеестрГосслужащих = ИспользоватьВыгрузкуВРеестрГосслужащих;
	
	ПараметрыНастроек.НастройкиМедицинскогоУчреждения.РаботаВМедицинскомУчреждении = РаботаВМедицинскомУчреждении;
	ПараметрыНастроек.НастройкиМедицинскогоУчреждения.ИспользоватьВыгрузкуВФедеральныйРегистрМедицинскихРаботников = ИспользоватьВыгрузкуВФедеральныйРегистрМедицинскихРаботников;
	ПараметрыНастроек.НастройкиМедицинскогоУчреждения.ИспользоватьТарификационнуюОтчетностьУчрежденийФМБА = ИспользоватьТарификационнуюОтчетностьУчрежденийФМБА;
	ПараметрыНастроек.НастройкиМедицинскогоУчреждения.ИспользоватьДоступКНаркотическимСредствам = ИспользоватьДоступКНаркотическимСредствам;
	
	ПараметрыНастроек.НастройкиОбразовательногоУчреждения.РаботаВОбразовательномУчреждении = РаботаВОбразовательномУчреждении;
	ПараметрыНастроек.НастройкиОбразовательногоУчреждения.НачисленияПреподавателей = НачисленияПреподавателей.Выгрузить(Новый Структура("Выбрано", Истина));
	
	НаименованиеЗадания = НСтр("ru = 'Сохранение настроек расчета зарплаты'");
	
	Результат = ДлительныеОперации.ЗапуститьВыполнениеВФоне(
		УникальныйИдентификатор,
		"Обработки.ПанельНастроекЗарплатаКадры.ЗаписатьНастройки",
		ПараметрыНастроек,
		НаименованиеЗадания);
	
	АдресХранилища = Результат.АдресХранилища;
	
	Если Результат.ЗаданиеВыполнено Тогда
		ОбновитьПовторноИспользуемыеЗначения();
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Процедура ЗаписатьНастройкиНаКлиенте(Результат = Неопределено, ДополнительныеПараметры = Неопределено) Экспорт
	
	
	НастройкиФормы = Новый Структура;
	НастройкиФормы.Вставить("ИспользоватьГосударственнуюСлужбу", ИспользоватьГосударственнуюСлужбу);
	НастройкиФормы.Вставить("ИспользоватьМуниципальнуюСлужбу", ИспользоватьМуниципальнуюСлужбу);
	НастройкиФормы.Вставить("ИспользоватьВоеннуюСлужбу", ИспользоватьВоеннуюСлужбу);  
	НастройкиФормы.Вставить("ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву", ИспользоватьРасчетДенежногоДовольствияВоеннослужащихПоПризыву);
	НастройкиФормы.Вставить("СообщениеОбОшибкахНастроек", "");
	
	Если Не НастройкиМожноЗаписать(НастройкиФормы) Тогда
		ПоказатьПредупреждение(,НастройкиФормы.СообщениеОбОшибкахНастроек);
		Возврат;
	КонецЕсли;
	
	Результат = ЗаписатьНастройкиНаСервере();
	
	Если Не Результат.ЗаданиеВыполнено Тогда
		ИдентификаторЗадания = Результат.ИдентификаторЗадания;
		АдресХранилища		 = Результат.АдресХранилища;
		
		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
		ФормаДлительнойОперации = ДлительныеОперацииКлиент.ОткрытьФормуДлительнойОперации(ЭтаФорма, ИдентификаторЗадания);
		
	Иначе
		
		Модифицированность = Ложь;
		ОбновитьПовторноИспользуемыеЗначения();
		ЗарплатаКадрыРасширенныйВызовСервера.ПередОбновлениемИнтерфейса();
		ОбновитьИнтерфейс();
		ОбновитьФормуПоНастройкам(ЭтаФорма);
		Модифицированность = Ложь;
				
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ЗаданиеВыполнено(ИдентификаторЗадания)
	
	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);
	
КонецФункции

&НаСервереБезКонтекста
Функция СообщенияФоновогоЗадания(ИдентификаторЗадания)
	
	СообщенияПользователю = Новый Массив;
	ФоновоеЗадание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(ИдентификаторЗадания);
	Если ФоновоеЗадание <> Неопределено Тогда
		СообщенияПользователю = ФоновоеЗадание.ПолучитьСообщенияПользователю();
	КонецЕсли;
	
	Возврат СообщенияПользователю;
	
КонецФункции

&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗадания()
	
	Попытка
		Если ФормаДлительнойОперации.Открыта() 
			И ФормаДлительнойОперации.ИдентификаторЗадания = ИдентификаторЗадания Тогда
			Если ЗаданиеВыполнено(ИдентификаторЗадания) Тогда
				ОбновитьПовторноИспользуемыеЗначения();
				ДлительныеОперацииКлиент.ЗакрытьФормуДлительнойОперации(ФормаДлительнойОперации);
				ЗарплатаКадрыРасширенныйВызовСервера.ПередОбновлениемИнтерфейса();
				ОбновитьИнтерфейс();
				ОбновитьФормуПоНастройкам(ЭтаФорма);

				Модифицированность = Ложь;
			Иначе
				ДлительныеОперацииКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
				ПодключитьОбработчикОжидания(
					"Подключаемый_ПроверитьВыполнениеЗадания",
					ПараметрыОбработчикаОжидания.ТекущийИнтервал,
					Истина);
			КонецЕсли;
		КонецЕсли;
	Исключение
		ДлительныеОперацииКлиент.ЗакрытьФормуДлительнойОперации(ФормаДлительнойОперации);
		
		СообщенияПользователю = СообщенияФоновогоЗадания(ИдентификаторЗадания);
		Если СообщенияПользователю <> Неопределено Тогда
			Для каждого СообщениеФоновогоЗадания Из СообщенияПользователю Цикл
				СообщениеФоновогоЗадания.Сообщить();
			КонецЦикла;
		КонецЕсли;
		
		ВызватьИсключение;
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти
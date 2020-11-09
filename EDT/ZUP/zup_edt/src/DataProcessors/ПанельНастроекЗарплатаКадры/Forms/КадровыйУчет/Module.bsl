#Область ОписаниеПеременных

&НаКлиенте
Перем ПараметрыОбработчикаОжидания;

&НаКлиенте
Перем ФормаДлительнойОперации;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Определяем показывать ли глобальную настройку по отключению и кадрами, и зарплатой.
	ДоступностьУстановкиИспользованияКадровогоУчетаИРасчетаЗарплаты = Ложь;
	ЗарплатаКадрыРасширенныйПереопределяемый.ОпределитьДоступностьУстановкиИспользованияЗарплатаКадры(ДоступностьУстановкиИспользованияКадровогоУчетаИРасчетаЗарплаты);
	Элементы.ГруппаИспользоватьКадровыйУчетИРасчетЗарплаты.Видимость = ДоступностьУстановкиИспользованияКадровогоУчетаИРасчетаЗарплаты;
	
	ПрочитатьНастройки();
	ОбновитьОписаниеНастроекШтатногоРасписания(ЭтаФорма);
	// Установка доступности элементов формы в зависимости от текущих настроек.
	УстановитьДоступностьЭлементовФормы(ЭтаФорма);
	УстановитьВидимостьЭлементовФормы(ЭтаФорма);
	УстановитьТекстПояснениеИспользоватьПереносОстатковОтпуска(ЭтотОбъект);
	
	Если ЗарплатаКадры.ЭтоБазоваяВерсияКонфигурации() Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ГруппаИспользоватьПодработки",
			"Видимость",
			Ложь);
			
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
			Элементы,
			"ГруппаПереносОстатковОтпуска",
			"Видимость",
			Ложь);
			
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ИспользоватьУниверсальнуюФормуСпискаСотрудниковГруппа",
		"Видимость",
		ИспользоватьПодробныеФормыСотрудников());
		
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)

	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтаФорма.ТребуетсяОбновлениеИнтерфейса Тогда
		ОбновитьИнтерфейс();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИзмененыНастройкиШтатногоРасписания" Тогда
		ПрочитатьНастройкиШтатногоРасписания();
		ОбновитьОписаниеНастроекШтатногоРасписания(ЭтаФорма);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИспользоватьКадровыйУчетИРасчетЗарплатыПриИзменении(Элемент)
	
	ИспользоватьКадровыйУчет = ИспользоватьКадровыйУчетИРасчетЗарплаты;
	ИспользоватьНачислениеЗарплаты = ИспользоватьКадровыйУчетИРасчетЗарплаты;
	
	Если ИспользоватьКадровыйУчетИРасчетЗарплаты Тогда
		// Восстанавливаем ранее запомненное состояние настроек.
		ЗаполнитьЗначенияСвойств(НастройкиВоинскогоУчета, НастройкиВоинскогоУчетаПрежняя);
		ЗаполнитьЗначенияСвойств(НастройкиКадровогоУчета, НастройкиКадровогоУчетаПрежняя);
		ЗаполнитьЗначенияСвойств(НастройкиШтатногоРасписания, НастройкиШтатногоРасписанияПрежняя);
		ЗаполнитьЗначенияСвойств(НастройкиЭлектронныхТрудовыхКнижек, НастройкиЭлектронныхТрудовыхКнижекПрежняя);
		
		Если ШтатноеРасписаниеВсегдаИспользуется() И НЕ НастройкиШтатногоРасписания.ИспользоватьШтатноеРасписание Тогда
			НастройкиШтатногоРасписания.ИспользоватьШтатноеРасписание = Истина;
		КонецЕсли;    
		
	Иначе
		// Сохраняем состояние
		ЗаполнитьЗначенияСвойств(НастройкиВоинскогоУчетаПрежняя, НастройкиВоинскогоУчета);
		ЗаполнитьЗначенияСвойств(НастройкиКадровогоУчетаПрежняя, НастройкиКадровогоУчета);
		ЗаполнитьЗначенияСвойств(НастройкиШтатногоРасписанияПрежняя, НастройкиШтатногоРасписания);
		ЗаполнитьЗначенияСвойств(НастройкиЭлектронныхТрудовыхКнижекПрежняя, НастройкиЭлектронныхТрудовыхКнижек);
		
		// Сбрасываем настройки
		НастройкиВоинскогоУчета.ИспользоватьВоинскийУчет = Ложь;
		НастройкиВоинскогоУчета.ИспользоватьБронированиеГраждан = Ложь;
		НастройкиВоинскогоУчета.ИспользуетсяТрудЛетноПодъемногоСостава = Ложь;
		НастройкиВоинскогоУчета.ИспользуетсяТрудПлавсостава = Ложь;
		
		НастройкиКадровогоУчета.ИспользоватьРаботуНаНеполнуюСтавку = Ложь;
		НастройкиКадровогоУчета.ИспользоватьПереносОстатковОтпускаПриУвольненииПереводом = Ложь;
		НастройкиКадровогоУчета.ВПоляхВводаСотрудниковУчитыватьИзмененияФамилии = Ложь;
		
		НастройкиЭлектронныхТрудовыхКнижек.ЗаполнятьСТДРВсемиМероприятиямиДо2020Года = Ложь;
		НастройкиЭлектронныхТрудовыхКнижек.ИспользоватьДляМероприятийПриемПереводУвольнениеДваДокументаОснования = Ложь;
		
		НастройкиШтатногоРасписания.ИспользоватьШтатноеРасписание = Ложь;
		НастройкиШтатногоРасписания.ИспользоватьРазрядыКатегорииКлассыДолжностейИПрофессийВШтатномРасписании = Ложь;
		НастройкиШтатногоРасписания.ИспользоватьИсториюИзмененияШтатногоРасписания = Ложь;
		НастройкиШтатногоРасписания.ПроверятьНаСоответствиеШтатномуРасписаниюАвтоматически = Ложь;
		НастройкиШтатногоРасписания.ИспользоватьВилкуСтавокВШтатномРасписании = Ложь;
		НастройкиШтатногоРасписания.ПредставлениеТарифовИНадбавок = ПредопределенноеЗначение("Перечисление.ПредставлениеТарифовИНадбавок.ПустаяСсылка");
		НастройкиШтатногоРасписания.ИспользоватьБронированиеПозиций = Ложь;
		
		ИспользоватьАттестацииСотрудников = Ложь;
		ИспользоватьМедицинскоеСтрахованиеСотрудников = Ложь;
	КонецЕсли;
	
	УстановитьДоступностьЭлементовФормы(ЭтаФорма);
	
	ЗаписатьНастройкиНаКлиенте("НастройкиКадровогоУчета,НастройкиВоинскогоУчета,НастройкиШтатногоРасписания,ИспользоватьКадровыйУчет,ИспользоватьНачислениеЗарплаты,ИспользоватьАттестацииСотрудников,ИспользоватьМедицинскоеСтрахованиеСотрудников,НастройкиЭлектронныхТрудовыхКнижек");
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ШтатноеРасписаниеВсегдаИспользуется()
	Возврат ЗарплатаКадрыРасширенный.ШтатноеРасписаниеВсегдаИспользуется();
КонецФункции

&НаКлиенте
Процедура НастройкиКадровогоУчетаКонтролироватьУникальностьТабельныхНомеровПриИзменении(Элемент)
	
	НастройкиКадровогоУчетаПрежняя.КонтролироватьУникальностьТабельныхНомеров = НастройкиКадровогоУчета.КонтролироватьУникальностьТабельныхНомеров;
	
	ЗаписатьНастройкиНаКлиенте("НастройкиКадровогоУчета");
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиКадровогоУчетаПечататьТ6ДляОтпусковПоБеременностиИРодамПриИзменении(Элемент)
	
	НастройкиКадровогоУчетаПрежняя.ПечататьТ6ДляОтпусковПоБеременностиИРодам = НастройкиКадровогоУчета.ПечататьТ6ДляОтпусковПоБеременностиИРодам;
	
	ЗаписатьНастройкиНаКлиенте("НастройкиКадровогоУчета");
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиКадровогоУчетаОтображатьИзмененияОплатыТрудаВЛичнойКарточкеПриИзменении(Элемент)
	
	НастройкиКадровогоУчетаПрежняя.ОтображатьИзмененияОплатыТрудаВЛичнойКарточке = НастройкиКадровогоУчета.ОтображатьИзмененияОплатыТрудаВЛичнойКарточке;
	
	ЗаписатьНастройкиНаКлиенте("НастройкиКадровогоУчета");
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиКадровогоУчетаПравилоФормированияПредставленияЭлементовСправочникаСотрудникиПриИзменении(Элемент)
	
	ОбновитьПравилоФормированияПредставленияЭлементовСправочникаСотрудники = Истина;
	НастройкиКадровогоУчетаПрежняя.ПравилоФормированияПредставленияЭлементовСправочникаСотрудники = НастройкиКадровогоУчета.ПравилоФормированияПредставленияЭлементовСправочникаСотрудники;
	ЗаписатьНастройкиНаКлиенте("НастройкиКадровогоУчета");
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьРаботуНаНеполнуюСтавкуПриИзменении(Элемент)
	
	НастройкиКадровогоУчетаПрежняя.ИспользоватьРаботуНаНеполнуюСтавку = НастройкиКадровогоУчета.ИспользоватьРаботуНаНеполнуюСтавку;
	
	ЗаписатьНастройкиНаКлиенте("НастройкиКадровогоУчета");
	
КонецПроцедуры

&НаКлиенте
Процедура ВПоляхВводаСотрудниковУчитыватьИзмененияФамилииПриИзменении(Элемент)
	
	НастройкиКадровогоУчетаПрежняя.ВПоляхВводаСотрудниковУчитыватьИзмененияФамилии = НастройкиКадровогоУчета.ВПоляхВводаСотрудниковУчитыватьИзмененияФамилии;
	
	ЗаписатьНастройкиНаКлиенте("НастройкиКадровогоУчета");
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьПодработкиПриИзменении(Элемент)
	
	ЗаписатьНастройкиНаКлиенте("ИспользоватьПодработки");
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьУниверсальнуюФормуСпискаСотрудниковПриИзменении(Элемент)
	
	ЗаписатьНастройкиНаКлиенте("ИспользоватьУниверсальнуюФормуСпискаСотрудников");
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

&НаКлиенте
Процедура УчитыватьПрерываниеСтажейАвтоматическиПриИзменении(Элемент)
	
	Если НЕ ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.АвтоматическийРасчетСтажейФизическихЛиц") Тогда
		Возврат;
	КонецЕсли;
	
	ЗаписатьНастройкиНаКлиенте("УчитыватьПрерываниеСтажейАвтоматически");
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьВоинскийУчетПриИзменении(Элемент)
	
	Если НастройкиВоинскогоУчета.ИспользоватьВоинскийУчет Тогда
		НастройкиВоинскогоУчета.ИспользоватьБронированиеГраждан = НастройкиВоинскогоУчетаПрежняя.ИспользоватьБронированиеГраждан;
		НастройкиВоинскогоУчета.ИспользуетсяТрудЛетноПодъемногоСостава = НастройкиВоинскогоУчетаПрежняя.ИспользуетсяТрудЛетноПодъемногоСостава;
		НастройкиВоинскогоУчета.ИспользуетсяТрудПлавсостава = НастройкиВоинскогоУчетаПрежняя.ИспользуетсяТрудПлавсостава;
	Иначе
		НастройкиВоинскогоУчетаПрежняя.ИспользоватьБронированиеГраждан = НастройкиВоинскогоУчета.ИспользоватьБронированиеГраждан;
		НастройкиВоинскогоУчетаПрежняя.ИспользуетсяТрудЛетноПодъемногоСостава = НастройкиВоинскогоУчета.ИспользуетсяТрудЛетноПодъемногоСостава;
		НастройкиВоинскогоУчетаПрежняя.ИспользуетсяТрудПлавсостава = НастройкиВоинскогоУчета.ИспользуетсяТрудПлавсостава;
		НастройкиВоинскогоУчета.ИспользоватьБронированиеГраждан = Ложь;
		НастройкиВоинскогоУчета.ИспользуетсяТрудЛетноПодъемногоСостава = Ложь;
		НастройкиВоинскогоУчета.ИспользуетсяТрудПлавсостава = Ложь;
	КонецЕсли;
	
	УстановитьДоступностьЭлементовФормыНастройкиВоинскогоУчета(Элементы, НастройкиВоинскогоУчета);
	
	ЗаписатьНастройкиНаКлиенте("НастройкиВоинскогоУчета");
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
		
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьБронированиеГражданПриИзменении(Элемент)
	
	Элементы.ГруппаВоинскийУчетСоставы.Доступность = НастройкиВоинскогоУчета.ИспользоватьБронированиеГраждан;
	
	Если НастройкиВоинскогоУчета.ИспользоватьБронированиеГраждан Тогда
		НастройкиВоинскогоУчета.ИспользуетсяТрудЛетноПодъемногоСостава = НастройкиВоинскогоУчетаПрежняя.ИспользуетсяТрудЛетноПодъемногоСостава;
		НастройкиВоинскогоУчета.ИспользуетсяТрудПлавсостава = НастройкиВоинскогоУчетаПрежняя.ИспользуетсяТрудПлавсостава;
	Иначе
		НастройкиВоинскогоУчетаПрежняя.ИспользуетсяТрудЛетноПодъемногоСостава = НастройкиВоинскогоУчета.ИспользуетсяТрудЛетноПодъемногоСостава;
		НастройкиВоинскогоУчетаПрежняя.ИспользуетсяТрудПлавсостава = НастройкиВоинскогоУчета.ИспользуетсяТрудПлавсостава;
		НастройкиВоинскогоУчета.ИспользуетсяТрудЛетноПодъемногоСостава = Ложь;
		НастройкиВоинскогоУчета.ИспользуетсяТрудПлавсостава = Ложь;
	КонецЕсли;
	
	НастройкиВоинскогоУчетаПрежняя.ИспользоватьБронированиеГраждан = НастройкиВоинскогоУчета.ИспользоватьБронированиеГраждан;
	
	ЗаписатьНастройкиНаКлиенте("НастройкиВоинскогоУчета");
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользуетсяТрудЛетноПодъемногоСоставаПриИзменении(Элемент)
	
	НастройкиВоинскогоУчетаПрежняя.ИспользуетсяТрудЛетноПодъемногоСостава = НастройкиВоинскогоУчета.ИспользуетсяТрудЛетноПодъемногоСостава;
	
	ЗаписатьНастройкиНаКлиенте("НастройкиВоинскогоУчета");
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользуетсяТрудПлавсоставаПриИзменении(Элемент)
	
	НастройкиВоинскогоУчетаПрежняя.ИспользуетсяТрудПлавсостава = НастройкиВоинскогоУчета.ИспользуетсяТрудПлавсостава;
	
	ЗаписатьНастройкиНаКлиенте("НастройкиВоинскогоУчета");
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкаШтатногоРасписания(Команда)
	ОткрытьФорму("Обработка.ПанельНастроекЗарплатаКадры.Форма.НастройкаШтатногоРасписания");
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьАттестацииСотрудниковПриИзменении(Элемент)
	
	Если НЕ ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыПриложения.АттестацииСотрудников") Тогда
		Возврат;
	КонецЕсли;
	
	Если РаботаВБюджетномУчреждении И ИспользоватьАттестацииСотрудников Тогда
		ИспользоватьОтдельныйДокументДляФормированияАттестационнойКомиссии = 1;
	КонецЕсли;
		
	Если ИспользоватьОтдельныйДокументДляФормированияАттестационнойКомиссии = 1
		И Не ИспользоватьАттестацииСотрудников Тогда
		ИспользоватьОтдельныйДокументДляФормированияАттестационнойКомиссии = 0;
	КонецЕсли;
	
	ЗаписатьНастройкиНаКлиенте("ИспользоватьАттестацииСотрудников,ИспользоватьОтдельныйДокументДляФормированияАттестационнойКомиссии");
	УстановитьДоступностьЭлементовФормыАттестацииСотрудников(ЭтотОбъект);
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьМедицинскоеСтрахованиеСотрудниковПриИзменении(Элемент)
	
	Если НЕ ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.МедицинскоеСтрахование") Тогда
		Возврат;
	КонецЕсли;
	
	ЗаписатьНастройкиНаКлиенте("ИспользоватьМедицинскоеСтрахованиеСотрудников");
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользованиеДокументаФормированиеАттестационнойКомиссииПриИзменении(Элемент)
	
	Если НЕ ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЗарплатаКадрыПриложения.АттестацииСотрудников") Тогда
		Возврат;	
	КонецЕсли;
	
	ЗаписатьНастройкиНаКлиенте("ИспользоватьОтдельныйДокументДляФормированияАттестационнойКомиссии");
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьСпециальностиФизическихЛицПриИзменении(Элемент)
	
	ЗаписатьНастройкиНаКлиенте("ИспользоватьСпециальностиФизическихЛиц");
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиКадровогоУчета(Команда)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыОтбора = Новый Структура;
	ПараметрыОтбора.Вставить("ПолеСортировкиРазделов", 3); 
	ПараметрыФормы.Вставить("СформироватьПриОткрытии", Истина);
	ПараметрыФормы.Вставить("Отбор", ПараметрыОтбора);
	ПараметрыФормы.Вставить("КлючВарианта", "НастройкиПоРазделам");
	
	ОткрытьФорму("Отчет.НастройкиПрограммыЗарплатаКадры.Форма", ПараметрыФормы, ЭтотОбъект, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоддерживатьНесколькоВременныхКадровыхИзмененийПриИзменении(Элемент)
	
	УстановитьВидимостьСпособовФормированияИнтервальныхРегистров(ЭтотОбъект);
	ЗаписатьСпособФормированияИнтервальныхРегистровНаСервере(ПоддерживатьНесколькоВременныхКадровыхИзменений);
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиЭлектронныхТрудовыхКнижекЗаполнятьСТДРВсемиМероприятиямиДо2020ГодаПриИзменении(Элемент)
	
	НастройкиЭлектронныхТрудовыхКнижекПрежняя.ЗаполнятьСТДРВсемиМероприятиямиДо2020Года = НастройкиЭлектронныхТрудовыхКнижек.ЗаполнятьСТДРВсемиМероприятиямиДо2020Года;
	
	ЗаписатьНастройкиНаКлиенте("НастройкиЭлектронныхТрудовыхКнижек");
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиЭлектронныхТрудовыхКнижекИспользоватьДляМероприятийПриемПереводУвольнениеДваДокументаОснованияПриИзменении(Элемент)
	
	НастройкиЭлектронныхТрудовыхКнижекПрежняя.ИспользоватьДляМероприятийПриемПереводУвольнениеДваДокументаОснования = НастройкиЭлектронныхТрудовыхКнижек.ИспользоватьДляМероприятийПриемПереводУвольнениеДваДокументаОснования;
	
	ЗаписатьНастройкиНаКлиенте("НастройкиЭлектронныхТрудовыхКнижек");
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьОбщийПериодОтпускаВДокументахПриИзменении(Элемент)
	
	ЗаписатьНастройкиНаКлиенте("ИспользоватьОбщийПериодОтпускаВДокументах");
	ПодключитьОбработчикОжиданияОбновленияИнтерфейса();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Процедура ЗаписатьСпособФормированияИнтервальныхРегистровНаСервере(ПоддерживатьНесколькоВременныхКадровыхИзменений)

	Если ПоддерживатьНесколькоВременныхКадровыхИзменений Тогда
		ЗначениеНастройки =
			Перечисления.СпособыФормированияИнтервальныхРегистров.ПоддерживатьНесколькоВложенныхПериодическихСобытийИнтервальныхРегистров;
	Иначе
		ЗначениеНастройки =
			Перечисления.СпособыФормированияИнтервальныхРегистров.НеПоддерживатьНесколькоВложенныхПериодическихСобытийИнтервальныхРегистров;
	КонецЕсли;
	Константы.СпособФормированияИнтервальныхРегистров.Установить(ЗначениеНастройки);

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОбновитьОписаниеНастроекШтатногоРасписания(Форма)

	Настройки = Форма.НастройкиШтатногоРасписания;
	ИспользоватьШтатноеРасписание = Настройки.ИспользоватьШтатноеРасписание;
	Если Не ИспользоватьШтатноеРасписание Тогда
		Описание = НСтр("ru = 'Возможность ведения штатного расписания отключена'");
	Иначе
		
		РаботаВБюджетномУчреждении = Форма.РаботаВБюджетномУчреждении;
		ИспользоватьНачислениеЗарплаты = Форма.ИспользоватьНачислениеЗарплаты;
		ШтатноеРасписаниеВсегдаИспользуется = Форма.ШтатноеРасписаниеВсегдаИспользуется;
		
		Автопроверка = Настройки.ПроверятьНаСоответствиеШтатномуРасписаниюАвтоматически;
		ИспользоватьИсторию = Настройки.ИспользоватьИсториюИзмененияШтатногоРасписания;
		ИспользоватьВилку = Настройки.ИспользоватьВилкуСтавокВШтатномРасписании;
		ИспользоватьРазрядыКатегории = Настройки.ИспользоватьРазрядыКатегорииКлассыДолжностейИПрофессийВШтатномРасписании;
		ИспользоватьБронированиеПозиций = Настройки.ИспользоватьБронированиеПозиций;
		ТекстАвтопроверка = ?(Автопроверка, НСтр("ru = 'Выполняется'"), НСтр("ru = 'Не выполняется'"));
		ТекстИспользоватьИсторию = ?(ИспользоватьИсторию, НСтр("ru = 'Ведется'"), НСтр("ru = 'Не ведется'"));
		ТекстИспользоватьРазрядыКатегории = ?(РаботаВБюджетномУчреждении,"",?(ИспользоватьРазрядыКатегории, НСтр("ru = 'Используются'"), НСтр("ru = 'Не используются'")));
		ТекстИспользоватьВилку = ?(ИспользоватьНачислениеЗарплаты,?(ИспользоватьВилку, НСтр("ru = 'Используется'"), НСтр("ru = 'Не используется'")),"");
		ТекстПредставлениеТарифовИНадбавок = ?(ИспользоватьНачислениеЗарплаты, Настройки.ПредставлениеТарифовИНадбавок,"");
		ТекстИспользоватьБронирование = ?(ИспользоватьБронированиеПозиций, НСтр("ru = 'Используется'"), НСтр("ru = 'Не используется'"));

		Описание = ?(ШтатноеРасписаниеВсегдаИспользуется, "", НСтр("ru = 'Ведется штатное расписание.'") + Символы.ПС);
		
		Описание = Описание + 
		НСтр("ru = '%1 автоматическая проверка кадровых документов на соответствие штатному расписанию.
		|%2 история изменения штатного расписания.'");
		
		Описание = ?(Не РаботаВБюджетномУчреждении, Описание + " 
		|" + НСтр("ru = '%3 разряды и категории в позиции штатного расписания.'"), Описание);
		
		Описание = ?(ИспользоватьНачислениеЗарплаты, Описание + "
		|" + НСтр("ru = '%4 ""вилка"" окладов и надбавок.'"), Описание);
		
			
		Описание = ?(ИспользоватьНачислениеЗарплаты, Описание + "
		|" + НСтр("ru = 'Надбавки в форме Т-3 отображаются как: %5'"), Описание);
		
		
		Описание = ?(ИспользоватьБронированиеПозиций, Описание + " 
		|" + НСтр("ru = '%6 бронирование позиций штатного расписания.'"), Описание);

		
		Описание = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Описание,
			ТекстАвтопроверка,
			ТекстИспользоватьИсторию,
			ТекстИспользоватьРазрядыКатегории,
			ТекстИспользоватьВилку,
			ТекстПредставлениеТарифовИНадбавок,
			ТекстИспользоватьБронирование);
		
	КонецЕсли;
	
	Форма.ОписаниеНастроекШтатногоРасписания = Описание;

КонецПроцедуры

&НаСервере
Процедура ПрочитатьНастройки()
	
	РаботаВБюджетномУчреждении = ПолучитьФункциональнуюОпцию("РаботаВБюджетномУчреждении");
	ИспользоватьНачислениеЗарплаты = ПолучитьФункциональнуюОпцию("ИспользоватьНачислениеЗарплаты");
	ШтатноеРасписаниеВсегдаИспользуется = ЗарплатаКадрыРасширенный.ШтатноеРасписаниеВсегдаИспользуется();
	
	ИспользоватьКадровыйУчетИРасчетЗарплаты = ПолучитьФункциональнуюОпцию("ИспользоватьКадровыйУчет") И ИспользоватьНачислениеЗарплаты;
	
	Настройки = РегистрыСведений.НастройкиКадровогоУчета.СоздатьМенеджерЗаписи();
	Настройки.Прочитать();
	
	ЗначениеВРеквизитФормы(Настройки, "НастройкиКадровогоУчета");
	ЗначениеВРеквизитФормы(Настройки, "НастройкиКадровогоУчетаПрежняя");
	
	Настройки = РегистрыСведений.НастройкиВоинскогоУчета.СоздатьМенеджерЗаписи();
	Настройки.Прочитать();
	
	ЗначениеВРеквизитФормы(Настройки, "НастройкиВоинскогоУчета");
	ЗначениеВРеквизитФормы(Настройки, "НастройкиВоинскогоУчетаПрежняя");
	
	Настройки = РегистрыСведений.НастройкиЭлектронныхТрудовыхКнижек.СоздатьМенеджерЗаписи();
	Настройки.Прочитать();
	
	ЗначениеВРеквизитФормы(Настройки, "НастройкиЭлектронныхТрудовыхКнижек");
	ЗначениеВРеквизитФормы(Настройки, "НастройкиЭлектронныхТрудовыхКнижекПрежняя");
	
	ПрочитатьНастройкиШтатногоРасписания();
	
	ПрочитатьНастройкиАттестацииСотрудников();
	ПрочитатьНастройкиМедицинскогоСтрахованияСотрудников();
	ПрочитатьУчитыватьПрерываниеСтажейАвтоматически();
	
	ИспользоватьСпециальностиФизическихЛиц = Константы.ИспользоватьСпециальностиФизическихЛиц.Получить();
	ИспользоватьПодработки = Константы.ИспользоватьПодработки.Получить();
	ИспользоватьОбщийПериодОтпускаВДокументах = Константы.ИспользоватьОбщийПериодОтпускаВДокументах.Получить();
	
	СпособФормированияИнтервальныхРегистров = Константы.СпособФормированияИнтервальныхРегистров.Получить();
	Если СпособФормированияИнтервальныхРегистров <> 
		Перечисления.СпособыФормированияИнтервальныхРегистров.НеПоддерживатьНесколькоВложенныхПериодическихСобытийИнтервальныхРегистров Тогда
		
		ПоддерживатьНесколькоВременныхКадровыхИзменений = Истина;
	КонецЕсли;
	
	Если ИспользоватьПодробныеФормыСотрудников() Тогда
		
		МодульСпискиСотрудников = ОбщегоНазначения.ОбщийМодуль("СпискиСотрудников");
		ИспользоватьУниверсальнуюФормуСпискаСотрудников = МодульСпискиСотрудников.ИспользоватьУниверсальнуюФормуСпискаСотрудников();
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьНастройкиШтатногоРасписания()

	Настройки = РегистрыСведений.НастройкиШтатногоРасписания.СоздатьМенеджерЗаписи();
	Настройки.Прочитать();
	ЗначениеВРеквизитФормы(Настройки, "НастройкиШтатногоРасписания");

КонецПроцедуры

&НаСервере
Процедура ПрочитатьНастройкиАттестацииСотрудников()
	
	Если НЕ ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.АттестацииСотрудников") Тогда
		Возврат;	
	КонецЕсли;
	
	Модуль = ОбщегоНазначения.ОбщийМодуль("АттестацииСотрудников");
	
	ИспользоватьАттестацииСотрудников = Модуль.ИспользуетсяАттестацияСотрудников();
	
	Если Модуль.ГрафикАттестацииИКомиссияУтверждаютсяОднимДокументом() Тогда
		ИспользоватьОтдельныйДокументДляФормированияАттестационнойКомиссии = 0;
	Иначе 
		ИспользоватьОтдельныйДокументДляФормированияАттестационнойКомиссии = 1	
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьНастройкиМедицинскогоСтрахованияСотрудников()
	
	Если НЕ ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.МедицинскоеСтрахование") Тогда
		Возврат;
	КонецЕсли;
	
	Модуль = ОбщегоНазначения.ОбщийМодуль("МедицинскоеСтрахование");
	
	ИспользоватьМедицинскоеСтрахованиеСотрудников = Модуль.ИспользуетсяМедицинскоеСтрахованиеСотрудников();
	
КонецПроцедуры

&НаСервере
Функция ЗаписатьНастройкиНаСервере(ИмяНастройки)
	
	ПараметрыНастроек = Обработки.ПанельНастроекЗарплатаКадры.ЗаполнитьСтруктуруПараметровНастроек(ИмяНастройки);
	ПараметрыНастроек.НастройкиКадровогоУчета = ОбщегоНазначения.СтруктураПоМенеджеруЗаписи(НастройкиКадровогоУчета, Метаданные.РегистрыСведений.НастройкиКадровогоУчета);
	ПараметрыНастроек.НастройкиВоинскогоУчета = ОбщегоНазначения.СтруктураПоМенеджеруЗаписи(НастройкиВоинскогоУчета, Метаданные.РегистрыСведений.НастройкиВоинскогоУчета);
	ПараметрыНастроек.НастройкиШтатногоРасписания = ОбщегоНазначения.СтруктураПоМенеджеруЗаписи(НастройкиШтатногоРасписания, Метаданные.РегистрыСведений.НастройкиШтатногоРасписания);
	ПараметрыНастроек.ИспользоватьКадровыйУчет = ИспользоватьКадровыйУчет;
	ПараметрыНастроек.ИспользоватьНачислениеЗарплаты = ИспользоватьНачислениеЗарплаты;
	ПараметрыНастроек.ИспользоватьАттестацииСотрудников = ИспользоватьАттестацииСотрудников;
	ПараметрыНастроек.ИспользоватьМедицинскоеСтрахованиеСотрудников = ИспользоватьМедицинскоеСтрахованиеСотрудников;
	ПараметрыНастроек.ИспользоватьОтдельныйДокументДляФормированияАттестационнойКомиссии = ИспользоватьОтдельныйДокументДляФормированияАттестационнойКомиссии > 0;
	ПараметрыНастроек.ИспользоватьСпециальностиФизическихЛиц = ИспользоватьСпециальностиФизическихЛиц;
	ПараметрыНастроек.ИспользоватьПодработки = ИспользоватьПодработки;
	ПараметрыНастроек.УчитыватьПрерываниеСтажейАвтоматически = УчитыватьПрерываниеСтажейАвтоматически;
	ПараметрыНастроек.ИспользоватьОбщийПериодОтпускаВДокументах = ИспользоватьОбщийПериодОтпускаВДокументах;
	ПараметрыНастроек.НастройкиЭлектронныхТрудовыхКнижек = ОбщегоНазначения.СтруктураПоМенеджеруЗаписи(НастройкиЭлектронныхТрудовыхКнижек, Метаданные.РегистрыСведений.НастройкиЭлектронныхТрудовыхКнижек);
	
	Если ИспользоватьПодробныеФормыСотрудников() Тогда
		ПараметрыНастроек.ИспользоватьУниверсальнуюФормуСпискаСотрудников = ИспользоватьУниверсальнуюФормуСпискаСотрудников;
	КонецЕсли;
	
	НаименованиеЗадания = НСтр("ru = 'Сохранение настроек кадрового учета'");
	Если ИмяНастройки = "НастройкиВоинскогоУчета" Тогда
		НаименованиеЗадания = НСтр("ru = 'Сохранение настроек воинского учета'");
	КонецЕсли;
	
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
Процедура ЗаписатьНастройкиНаКлиенте(ИмяНастройки)
	
	Результат = ЗаписатьНастройкиНаСервере(ИмяНастройки);
	
	Если Не Результат.ЗаданиеВыполнено Тогда
		ИдентификаторЗадания = Результат.ИдентификаторЗадания;
		АдресХранилища		 = Результат.АдресХранилища;
		
		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
		ФормаДлительнойОперации = ДлительныеОперацииКлиент.ОткрытьФормуДлительнойОперации(ЭтаФорма, ИдентификаторЗадания);
	Иначе
		ОбновитьПравилоФормированияПредставленияСправочникаСотрудникиНаКлиенте();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьТекстПояснениеИспользоватьПереносОстатковОтпуска(Форма)
	Текст = НСтр("ru = 'На предприятии разрешается переносить остатки отпусков при переводе сотрудников между организациями'");
	Форма.ПояснениеИспользоватьПереносОстатковОтпускаПриУвольненииПереводом = Текст;	
КонецПроцедуры

#Область ОбновлениеИнтерфейса

&НаКлиенте
Процедура ПодключитьОбработчикОжиданияОбновленияИнтерфейса()
	
	ТребуетсяОбновлениеИнтерфейса = Истина;
	ПодключитьОбработчикОжидания("ОбработчикОжиданияОбновленияИнтерфейса", 1, Истина);
	
КонецПроцедуры

&НаКлиенте 
Процедура ОбработчикОжиданияОбновленияИнтерфейса()
	
	ЗарплатаКадрыРасширенныйВызовСервера.ПередОбновлениемИнтерфейса();
	
	ОбновитьИнтерфейс();
		
	ЭтаФорма.ТребуетсяОбновлениеИнтерфейса = Ложь;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьЭлементовФормы(Форма)
	
	ДоступностьНастроек = Форма.ИспользоватьКадровыйУчетИРасчетЗарплаты;
	
	Форма.Элементы.НастройкаШтатногоРасписания.Доступность = ДоступностьНастроек;
	Форма.Элементы.ГруппаНеполнаяСтавка.Доступность = ДоступностьНастроек;
	Форма.Элементы.ГруппаПереносОстатковОтпуска.Доступность = ДоступностьНастроек;
	Форма.Элементы.ГруппаВоинскийУчет.Доступность = ДоступностьНастроек;
	Форма.Элементы.ГруппаАттестацииСотрудников.Доступность = ДоступностьНастроек;
	Форма.Элементы.ГруппаМедицинскоеСтрахованиеСотрудников.Доступность = ДоступностьНастроек;
	УстановитьДоступностьЭлементовФормыНастройкиВоинскогоУчета(Форма.Элементы, Форма.НастройкиВоинскогоУчета);
	УстановитьДоступностьЭлементовФормыАттестацииСотрудников(Форма);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьЭлементовФормы(Форма)
	
	УстановитьВидимостьЭлементовФормыАттестацииСотрудников(Форма);
	УстановитьВидимостьЭлементовФормыМедицинскогоСтрахованияСотрудников(Форма);
	УстановитьВидимостьЭлементовФормыУчитыватьПрерываниеСтажейАвтоматически(Форма);
	УстановитьВидимостьСпособовФормированияИнтервальныхРегистров(Форма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьЭлементовФормыНастройкиВоинскогоУчета(Элементы, НастройкиВоинскогоУчета)

	Элементы.ГруппаНастройкиВоинскогоУчета.Доступность = НастройкиВоинскогоУчета.ИспользоватьВоинскийУчет;
	Элементы.ГруппаВоинскийУчетСоставы.Доступность     = НастройкиВоинскогоУчета.ИспользоватьБронированиеГраждан;

КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьДоступностьЭлементовФормыАттестацииСотрудников(Форма)
	
	Если НЕ ОбщегоНазначенияБЗККлиентСервер.ПодсистемаСуществует("ЗарплатаКадрыПриложения.АттестацииСотрудников") Тогда
		Возврат;	
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "ИспользоватьОтдельныйДокументДляФормированияАттестационнойКомиссии", "Доступность", Форма.ИспользоватьАттестацииСотрудников);
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьУчитыватьПрерываниеСтажейАвтоматически()
	
	Если НЕ ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.АвтоматическийРасчетСтажейФизическихЛиц") Тогда
		Возврат;
	КонецЕсли;
	
	МодульАвтоматическийРасчетСтажейФизическихЛиц = ОбщегоНазначения.ОбщийМодуль("АвтоматическийРасчетСтажейФизическихЛиц");
	УчитыватьПрерываниеСтажейАвтоматически = МодульАвтоматическийРасчетСтажейФизическихЛиц.УчитыватьПрерываниеСтажейАвтоматически();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьЭлементовФормыУчитыватьПрерываниеСтажейАвтоматически(Форма)
	
	Если ОбщегоНазначенияБЗККлиентСервер.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.АвтоматическийРасчетСтажейФизическихЛиц") Тогда
		ВидимостьНастроек = Истина;
	Иначе
		ВидимостьНастроек = Ложь;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"ГруппаУчитыватьПрерываниеСтажейАвтоматически",
		"Видимость",
		ВидимостьНастроек);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьЭлементовФормыАттестацииСотрудников(Форма)
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "ГруппаАттестацииСотрудников", "Видимость", ДоступныАттестацииСотрудников());
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьСпособовФормированияИнтервальныхРегистров(Форма)
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Форма.Элементы,
		"СпособФормированияИнтервальныхРегистровГруппа",
		"Видимость",
		ЗначениеЗаполнено(Форма.СпособФормированияИнтервальныхРегистров));
		
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьЭлементовФормыМедицинскогоСтрахованияСотрудников(Форма)
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы, "ГруппаМедицинскоеСтрахованиеСотрудников", "Видимость", ДоступноМедицинскоеСтрахованиеСотрудников());
	
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
				ОбновитьПравилоФормированияПредставленияСправочникаСотрудникиНаКлиенте();
				ДлительныеОперацииКлиент.ЗакрытьФормуДлительнойОперации(ФормаДлительнойОперации);
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

&НаКлиенте
Процедура ОбновитьПравилоФормированияПредставленияСправочникаСотрудникиНаКлиенте()
	
	Если ОбновитьПравилоФормированияПредставленияЭлементовСправочникаСотрудники Тогда
			
		ОбновитьПравилоФормированияПредставленияСправочникаСотрудники();
		ОбновитьПравилоФормированияПредставленияЭлементовСправочникаСотрудники = Ложь;
			
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Процедура ОбновитьПравилоФормированияПредставленияСправочникаСотрудники()
	
	КадровыйУчетРасширенный.УстановитьПараметрСеансаПравилоФормированияПредставленияЭлементовСправочникаСотрудники();
		
КонецПроцедуры

&НаСервере
Функция ДоступныАттестацииСотрудников()
	
	Возврат ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыПриложения.АттестацииСотрудников")
		И (ПолучитьФункциональнуюОпцию("ИспользоватьЗарплатаКадрыКорпоративнаяПодсистемы") 
		ИЛИ ПолучитьФункциональнуюОпцию("РаботаВБюджетномУчреждении"));
	
КонецФункции

&НаСервере
Функция ДоступноМедицинскоеСтрахованиеСотрудников()
	
	Возврат ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.МедицинскоеСтрахование")
		И ПолучитьФункциональнуюОпцию("ИспользоватьЗарплатаКадрыКорпоративнаяПодсистемы");
	
КонецФункции

&НаСервере
Функция ИспользоватьПодробныеФормыСотрудников()
	
	Возврат ПолучитьФункциональнуюОпцию("ИспользоватьЗарплатаКадрыКорпоративнаяПодсистемы")
		И ОбщегоНазначения.ПодсистемаСуществует("ЗарплатаКадрыКорпоративнаяПодсистемы.КадровыйУчет.СпискиСотрудников");
	
КонецФункции

#КонецОбласти

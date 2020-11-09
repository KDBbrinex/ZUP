#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов


// Проводит документ по учетам. Если в параметре ВидыУчетов передано Неопределено, то документ проводится по всем учетам.
// Процедура вызывается из обработки проведения и может вызываться из вне.
// 
// Параметры:
//  ДокументСсылка	- ДокументСсылка.Отгул - Ссылка на документ
//  РежимПроведения - РежимПроведенияДокумента - Режим проведения документа (оперативный, неоперативный)
//  Отказ 			- Булево - Признак отказа от выполнения проведения
//  ВидыУчетов 		- Строка - Список видов учета, по которым необходимо провести документ. Если параметр пустой или Неопределено, то документ проведется по всем учетам
//  Движения 		- Коллекция движений документа - Передается только при вызове из обработки проведения документа
//  Объект			- ДокументОбъект.Отгул - Передается только при вызове из обработки проведения документа
//  ДополнительныеПараметры - Структура - Дополнительные параметры, необходимые для проведения документа.
//
Процедура ПровестиПоУчетам(ДокументСсылка, РежимПроведения, Отказ, ВидыУчетов = Неопределено, Движения = Неопределено, Объект = Неопределено, ДополнительныеПараметры = Неопределено) Экспорт
	
	СтруктураВидовУчета = ПроведениеРасширенныйСервер.СтруктураВидовУчета();
	ПроведениеРасширенныйСервер.ПодготовитьНаборыЗаписейКРегистрацииДвиженийПоВидамУчета(РежимПроведения, ДокументСсылка, СтруктураВидовУчета, ВидыУчетов, Движения, Объект, Отказ);
	
	РеквизитыДляПроведения = РеквизитыДляПроведения(ДокументСсылка);
	ДанныеДляПроведения = ДанныеДляПроведения(РеквизитыДляПроведения, СтруктураВидовУчета);
	
	ИсправлениеДокументовЗарплатаКадры.ПриПроведенииИсправления(ДокументСсылка, Движения, РежимПроведения, Отказ, РеквизитыДляПроведения, СтруктураВидовУчета, Объект);
	
	Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда

		ЗарегистрироватьВнутрисменныеОтклонения(Движения, РеквизитыДляПроведения);
				
	КонецЕсли;
	
	Если РеквизитыДляПроведения.ПерерасчетВыполнен Тогда 
		
		Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда

			РасчетЗарплатыРасширенный.СформироватьДвиженияНачислений(Движения, Отказ, РеквизитыДляПроведения.Организация, КонецМесяца(РеквизитыДляПроведения.ПериодРегистрации), ДанныеДляПроведения.Начисления, ДанныеДляПроведения.ПоказателиНачислений, Истина);
			
			РасчетЗарплатыРасширенный.СформироватьДвиженияРаспределенияПоТерриториямУсловиямТруда(Движения, Отказ, РеквизитыДляПроведения.Ссылка, РеквизитыДляПроведения.РаспределениеПоТерриториямУсловиямТруда);
			РасчетЗарплатыРасширенный.СформироватьДвиженияРаспределенияРезультатовНачислений(Движения, Отказ, РеквизитыДляПроведения.Ссылка, РеквизитыДляПроведения.РаспределениеРезультатовНачислений);
			ПерерасчетЗарплаты.СформироватьДвиженияИсходныеДанныхПерерасчетов(Движения, РеквизитыДляПроведения.Организация, РеквизитыДляПроведения.ПериодРегистрации, ДанныеДляПроведения.Начисления);
			
			ПроверитьПересечениеФактическогоПериодаДействия(ДокументСсылка, Отказ);
			
			// Заполним описание данных для проведения в учете начисленной зарплаты.
			ДанныеДляПроведенияУчетЗарплаты = ОтражениеЗарплатыВУчете.ОписаниеДанныеДляПроведения();
			ДанныеДляПроведенияУчетЗарплаты.Движения 				= Движения;
			ДанныеДляПроведенияУчетЗарплаты.Организация 			= РеквизитыДляПроведения.Организация;
			ДанныеДляПроведенияУчетЗарплаты.ПериодРегистрации 		= РеквизитыДляПроведения.ПериодРегистрации;
			ДанныеДляПроведенияУчетЗарплаты.ПорядокВыплаты 			= Перечисления.ХарактерВыплатыЗарплаты.Зарплата;
			ДанныеДляПроведенияУчетЗарплаты.МенеджерВременныхТаблиц = ДанныеДляПроведения.МенеджерВременныхТаблиц;
			
			// - Регистрация начислений в учете начислений и удержаний.
			УчетНачисленнойЗарплаты.ЗарегистрироватьНачисления(ДанныеДляПроведенияУчетЗарплаты, Отказ, ДанныеДляПроведения.НачисленияПоСотрудникам, Неопределено);
			УчетНачисленнойЗарплаты.ЗарегистрироватьОтработанноеВремя(ДанныеДляПроведенияУчетЗарплаты, Отказ, ДанныеДляПроведения.ОтработанноеВремяПоСотрудникам, Истина);

			// - Регистрация начислений в бухучете.
			ОтражениеЗарплатыВБухучетеРасширенный.ЗарегистрироватьНачисленияУдержания(ДанныеДляПроведенияУчетЗарплаты, Отказ,
				ДанныеДляПроведения.НачисленияПоСотрудникам, Неопределено, Неопределено);
				
			ДатаОперацииПоНалогам = УчетНДФЛ.ДатаОперацииПоДокументу(РеквизитыДляПроведения.Дата, РеквизитыДляПроведения.ПериодРегистрации);
				
			УчетНДФЛРасширенный.СформироватьДоходыНДФЛПоНачислениям(Движения, Отказ, РеквизитыДляПроведения.Организация, 
				ДатаОперацииПоНалогам, КонецМесяца(РеквизитыДляПроведения.ПериодРегистрации),
				ДанныеДляПроведения.МенеджерВременныхТаблиц, , , , "ВТНачисленияДляУчетаДоходовНДФЛ", ДокументСсылка);
						
			// Дополняем доходы НДФЛ сведениями о распределении по статьям финансирования и/или статьям расходов.
			ОтражениеЗарплатыВУчетеРасширенный.ДополнитьСведенияОДоходахНДФЛСведениямиОРаспределенииПоСтатьям(Движения);
			
			// - Регистрация начислений в доходах для страховых взносов.
			УчетСтраховыхВзносов.СформироватьСведенияОДоходахСтраховыеВзносы(Движения, Отказ, РеквизитыДляПроведения.Организация, РеквизитыДляПроведения.ПериодРегистрации, ДанныеДляПроведения.МенеджерВременныхТаблиц, Ложь, Истина, РеквизитыДляПроведения.Ссылка);
			
		КонецЕсли;
		
		Если СтруктураВидовУчета.ДанныеДляРасчетаСреднего Тогда
			
			// Учет среднего заработка
			УчетСреднегоЗаработка.ЗарегистрироватьДанныеСреднегоЗаработка(Движения, Отказ, ДанныеДляПроведения.НачисленияДляСреднегоЗаработка);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда

		Если Не РеквизитыДляПроведения.ОтсутствиеВТечениеЧастиСмены Тогда 
			СостояниеСотрудника = ПредопределенноеЗначение("Перечисление.СостоянияСотрудника.ДополнительныеВыходныеДниНеОплачиваемые");
			СостоянияСотрудников.ЗарегистрироватьСостояниеСотрудника(Движения, РеквизитыДляПроведения.Ссылка, РеквизитыДляПроведения.Сотрудник, СостояниеСотрудника, РеквизитыДляПроведения.ДатаНачала, РеквизитыДляПроведения.ДатаОкончания);
			УчетСтажаПФР.ЗарегистрироватьПериодыВУчетеСтажаПФР(Движения, ДанныеДляРегистрацииВУчетаСтажаПФР(РеквизитыДляПроведения.Ссылка)[РеквизитыДляПроведения.Ссылка]);
		КонецЕсли;
		
		Если Не РеквизитыДляПроведения.ОтсутствиеВТечениеЧастиСмены И РеквизитыДляПроведения.ОсвобождатьСтавку Тогда
			
			ЗарплатаКадрыРасширенный.УстановитьВремяРегистрацииДокумента(Движения, РеквизитыДляПроведения.СотрудникиДаты, РеквизитыДляПроведения.Ссылка);
			КадровыйУчетРасширенный.СформироватьДвиженияЗанятостиВременноОсвобожденныхПозицииШтатногоРасписания(
				Движения, РеквизитыДляПроведения.Сотрудник, РеквизитыДляПроведения.ДатаНачала, РеквизитыДляПроведения.ДатаОкончания, Ложь);
			
		КонецЕсли;
			
		// Регистрация отгулов.
		ДанныеОбОтгулах = ДанныеОбОтгулах(РеквизитыДляПроведения);
		УчетРабочегоВремениРасширенный.ЗарегистрироватьИПроверитьОстаткиДниЧасыОтгуловСотрудников(Движения, ДанныеОбОтгулах, Отказ);
		
		ПерерасчетЗарплаты.УдалитьПерерасчетыПоДополнительнымПараметрам(РеквизитыДляПроведения.Ссылка, ДополнительныеПараметры);
		
	КонецЕсли;
	
	ПроведениеРасширенныйСервер.ЗаписьДвиженийПоУчетам(Движения, СтруктураВидовУчета);
	
КонецПроцедуры

// Сторнирует документ по учетам. Используется подсистемой исправления документов.
//
// Параметры:
//  Движения				 - КоллекцияДвижений, Структура	 - Коллекция движений исправляющего документа в которую будут добавлены сторно стоки.
//  Регистратор				 - ДокументСсылка				 - Документ регистратор исправления (документ исправление).
//  ИсправленныйДокумент	 - ДокументСсылка				 - Исправленный документ движения которого будут сторнированы.
//  СтруктураВидовУчета		 - Структура					 - Виды учета, по которым будет выполнено сторнирование исправленного документа.
//  					Состав полей см. в ПроведениеРасширенныйСервер.СтруктураВидовУчета().
//  ДополнительныеПараметры	 - Структура					 - Структура со свойствами:
//  					* ИсправлениеВТекущемПериоде - Булево - Истина когда исправление выполняется в периоде регистрации исправленного документа.
//						* ОтменаДокумента - Булево - Истина когда исправление вызвано документом СторнированиеНачислений.
//  					* ПериодРегистрации	- Дата - Период регистрации документа регистратора исправления.
// 
// Возвращаемое значение:
//  Булево - "Истина" если сторнирование выполнено этой функцией, "Ложь" если специальной процедуры не предусмотрено.
//
Функция СторнироватьПоУчетам(Движения, Регистратор, ИсправленныйДокумент, СтруктураВидовУчета, ДополнительныеПараметры) Экспорт
	
	РеквизитыДляПроведения = ДополнительныеПараметры.РеквизитыДляПроведения;
	Если ДополнительныеПараметры.ОтменаДокумента Тогда
		// При отмене документа реквизиты для проведения сформированы документом СторнированиеНачислений,
		// их структура отличается от реквизитов для проведения исправленного документа.
		РеквизитыИсправленногоДокумента = РеквизитыДляПроведения(ИсправленныйДокумент);
		РеквизитыДляПроведения.Вставить("Сотрудник", РеквизитыИсправленногоДокумента.Сотрудник);
	КонецЕсли;
	
	Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда
		
		Сотрудники = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(РеквизитыДляПроведения.Сотрудник);
		УчетРабочегоВремениРасширенный.ЗарегистрироватьСторноЗаписиПоДокументу(Движения, РеквизитыДляПроведения.ПериодРегистрации, ИсправленныйДокумент, Сотрудники);
		УчетРабочегоВремениРасширенный.СторнироватьДниЧасыОтгуловСотрудников(Движения, ИсправленныйДокумент);
		
	КонецЕсли;
	
	Если ДополнительныеПараметры.ОтменаДокумента Тогда
		
		Если СтруктураВидовУчета.ДанныеДляРасчетаСреднего Тогда
			УчетСреднегоЗаработка.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент);
		КонецЕсли;
		
		Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда
			РасчетЗарплатыРасширенный.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент, ДополнительныеПараметры);
			УчетСтраховыхВзносовРасширенный.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент, ДополнительныеПараметры);
			УчетНДФЛРасширенный.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент, ДополнительныеПараметры);
			УчетНачисленнойЗарплатыРасширенный.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент, ДополнительныеПараметры);
			
			ИсправлениеДокументовЗарплатаКадры.СторнироватьДвиженияБезСпецификиУчетов(
				Движения, ИсправленныйДокумент, ДополнительныеПараметры);
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|	И ЗначениеРазрешено(ФизическоеЛицо)";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает описание состава документа
//
// Возвращаемое значение:
//  Структура - см. ЗарплатаКадрыСоставДокументов.НовоеОписаниеСоставаОбъекта.
Функция ОписаниеСоставаОбъекта() Экспорт
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаОбъектаФизическоеЛицоВШапке();
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДобавитьКомандыСозданияДокументов(КомандыСозданияДокументов, ДополнительныеПараметры) Экспорт
	
	ЗарплатаКадрыРасширенный.ДобавитьВКоллекциюКомандуСозданияДокументаПоМетаданнымДокумента(
		КомандыСозданияДокументов, Метаданные.Документы.Отгул);
	
КонецФункции

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Обработчик = "УправлениеПечатьюБЗККлиент.ВыполнитьКомандуПечати";
	КомандаПечати.Идентификатор = "ПФ_MXL_Отгул";
	КомандаПечати.Представление = НСтр("ru = 'Отгул'");
	
КонецПроцедуры

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ПФ_MXL_Отгул") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
						КоллекцияПечатныхФорм, 
						"ПФ_MXL_Отгул", 
						("ru = 'Приказ о предоставлении дополнительного времени отдыха'"), 
						ПечатнаяФормаПриказаОПредоставленииОтгула(МассивОбъектов, ОбъектыПечати), ,
						"Документ.Отгул.ПФ_MXL_Отгул");
	КонецЕсли;
	
КонецПроцедуры

Функция ПечатнаяФормаПриказаОПредоставленииОтгула(МассивОбъектов, ОбъектыПечати)
	
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.Отгул.ПФ_MXL_Отгул");
	
	ДокументРезультат = Новый ТабличныйДокумент;
	ДокументРезультат.КлючПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_Отгул";
	
	ДанныеДляПечати = ДанныеДляПечатиПриказаОПредоставленииОтгула(МассивОбъектов);
	ПервыйПриказ = Истина;
	
	Выборка = ДанныеДляПечати.Выбрать();
	Пока Выборка.Следующий() Цикл 
		
		НомерСтрокиНачало = ДокументРезультат.ВысотаТаблицы + 1;
		
		Если Не ПервыйПриказ Тогда
			ДокументРезультат.ВывестиГоризонтальныйРазделительСтраниц();
		Иначе
			ПервыйПриказ = Ложь;
		КонецЕсли;
		
		ОбластьШапка = Макет.ПолучитьОбласть("Шапка");
		ОбластьШапка.Параметры.Заполнить(Выборка);
		
		НастройкиПечатныхФорм = ЗарплатаКадрыПовтИсп.НастройкиПечатныхФорм();
		Если НастройкиПечатныхФорм.УдалятьПрефиксыОрганизацииИИБИзНомеровКадровыхПриказов Тогда
			ОбластьШапка.Параметры.НомерДок = ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(Выборка.НомерДок, Истина, Истина);
		КонецЕсли;
		
		ОбластьШапка.Параметры.ТабельныйНомер = ПрефиксацияОбъектовКлиентСервер.УдалитьПрефиксыИзНомераОбъекта(Выборка.ТабельныйНомер, Истина, Истина);
		ОбластьШапка.Параметры.НазваниеОрганизации = ?(ЗначениеЗаполнено(Выборка.ПолноеНаименованиеОрганизации), Выборка.ПолноеНаименованиеОрганизации, Выборка.НаименованиеОрганизации);
		
		ПредставлениеДней   = НСтр("ru = ';%1 день;;%1 дня;%1 дней;%1 дня'");
		ПредставлениеЧасов  = НСтр("ru = ';%1 час;;%1 часа;%1 часов;%1 часа'");
		
		ОбластьШапка.Параметры.ДнейЧасов = ?(Выборка.ОтсутствиеВТечениеЧастиСмены, 
			СтроковыеФункцииКлиентСервер.СтрокаСЧисломДляЛюбогоЯзыка(ПредставлениеЧасов, Выборка.КоличествоЧасовОтгула), 
			СтроковыеФункцииКлиентСервер.СтрокаСЧисломДляЛюбогоЯзыка(ПредставлениеДней, Выборка.КоличествоДнейОтгула));
		
		ДокументРезультат.Вывести(ОбластьШапка);
		
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ДокументРезультат, НомерСтрокиНачало, ОбъектыПечати, Выборка.Сотрудник);
		
	КонецЦикла;
	
	Возврат ДокументРезультат;
	
КонецФункции

Функция ДанныеДляПечатиПриказаОПредоставленииОтгула(МассивОбъектов)
	
	Запрос = Новый Запрос;
	
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("СписокДокументов", МассивОбъектов);
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	Отгул.Ссылка КАК Ссылка,
	               |	Отгул.Номер КАК Номер,
	               |	Отгул.Дата КАК Дата,
	               |	Отгул.Организация КАК Организация,
	               |	Отгул.Сотрудник КАК Сотрудник,
	               |	ВЫБОР
	               |		КОГДА Отгул.ОтсутствиеВТечениеЧастиСмены
	               |			ТОГДА Отгул.ДатаОтсутствия
	               |		ИНАЧЕ Отгул.ДатаНачала
	               |	КОНЕЦ КАК Период,
	               |	ВЫБОР
	               |		КОГДА Отгул.ОтсутствиеВТечениеЧастиСмены
	               |			ТОГДА Отгул.ДатаОтсутствия
	               |		ИНАЧЕ Отгул.ДатаОкончания
	               |	КОНЕЦ КАК ДатаОкончания,
	               |	Отгул.КоличествоДнейОтгула КАК КоличествоДнейОтгула,
	               |	Отгул.ОтсутствиеВТечениеЧастиСмены КАК ОтсутствиеВТечениеЧастиСмены,
	               |	Отгул.КоличествоЧасовОтгула КАК КоличествоЧасовОтгула,
	               |	Отгул.Основание КАК Основание,
	               |	Отгул.Руководитель КАК Руководитель,
	               |	Отгул.ДолжностьРуководителя КАК ДолжностьРуководителя
	               |ПОМЕСТИТЬ ВТДанныеДокументов
	               |ИЗ
	               |	Документ.Отгул КАК Отгул
	               |ГДЕ
	               |	Отгул.Ссылка В(&СписокДокументов)
	               |
	               |ОБЪЕДИНИТЬ ВСЕ
	               |
	               |ВЫБРАТЬ
	               |	ОтгулСпискомСотрудники.Ссылка,
	               |	ОтгулСпискомСотрудники.Ссылка.Номер,
	               |	ОтгулСпискомСотрудники.Ссылка.Дата,
	               |	ОтгулСпискомСотрудники.Ссылка.Организация,
	               |	ОтгулСпискомСотрудники.Сотрудник,
	               |	ОтгулСпискомСотрудники.ДатаНачала,
	               |	ОтгулСпискомСотрудники.ДатаОкончания,
	               |	ОтгулСпискомСотрудники.КоличествоДнейОтгула,
	               |	ЛОЖЬ,
	               |	0,
	               |	ОтгулСпискомСотрудники.Основание,
	               |	ОтгулСпискомСотрудники.Ссылка.Руководитель,
	               |	ОтгулСпискомСотрудники.Ссылка.ДолжностьРуководителя
	               |ИЗ
	               |	Документ.ОтгулСписком.Сотрудники КАК ОтгулСпискомСотрудники
	               |ГДЕ
	               |	ОтгулСпискомСотрудники.Ссылка В(&СписокДокументов)";
	
	Запрос.Выполнить();
	
	ОписательВременныхТаблиц = КадровыйУчет.ОписательВременныхТаблицДляСоздатьВТКадровыеДанныеСотрудников(Запрос.МенеджерВременныхТаблиц, "ВТДанныеДокументов");
	КадровыйУчет.СоздатьВТКадровыеДанныеСотрудников(ОписательВременныхТаблиц, Истина, "ФИОПолные,ТабельныйНомер,Организация,Подразделение,Должность");
	
	ЗарплатаКадры.СоздатьВТФИООтветственныхЛиц(Запрос.МенеджерВременныхТаблиц, Истина, "Руководитель", "ВТДанныеДокументов");
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	ДанныеДокументов.Ссылка КАК Ссылка,
	               |	ДанныеДокументов.Номер КАК НомерДок,
	               |	ДанныеДокументов.Дата КАК ДатаДок,
	               |	ДанныеДокументов.Организация КАК Организация,
	               |	ДанныеДокументов.Организация.Наименование КАК НаименованиеОрганизации,
	               |	ДанныеДокументов.Организация.НаименованиеПолное КАК ПолноеНаименованиеОрганизации,
	               |	ДанныеДокументов.Сотрудник КАК Сотрудник,
	               |	КадровыеДанныеСотрудников.ФИОПолные КАК ФИОПолные,
	               |	КадровыеДанныеСотрудников.ТабельныйНомер КАК ТабельныйНомер,
	               |	КадровыеДанныеСотрудников.Подразделение.Наименование КАК Подразделение,
	               |	КадровыеДанныеСотрудников.Должность.Наименование КАК Должность,
	               |	ДанныеДокументов.Период КАК ДатаНачала,
	               |	ДанныеДокументов.ДатаОкончания КАК ДатаОкончания,
	               |	ДанныеДокументов.КоличествоДнейОтгула КАК КоличествоДнейОтгула,
	               |	ДанныеДокументов.ОтсутствиеВТечениеЧастиСмены КАК ОтсутствиеВТечениеЧастиСмены,
	               |	ДанныеДокументов.КоличествоЧасовОтгула КАК КоличествоЧасовОтгула,
	               |	ДанныеДокументов.Основание КАК Основание,
	               |	ДанныеДокументов.Руководитель КАК Руководитель,
	               |	ДанныеДокументов.ДолжностьРуководителя.Наименование КАК ДолжностьРуководителя,
	               |	ФИООтветственныхЛиц.РасшифровкаПодписи КАК РуководительРасшифровкаПодписи
	               |ИЗ
	               |	ВТДанныеДокументов КАК ДанныеДокументов
	               |		ЛЕВОЕ СОЕДИНЕНИЕ ВТКадровыеДанныеСотрудников КАК КадровыеДанныеСотрудников
	               |		ПО ДанныеДокументов.Сотрудник = КадровыеДанныеСотрудников.Сотрудник
	               |			И ДанныеДокументов.Период = КадровыеДанныеСотрудников.Период
	               |		ЛЕВОЕ СОЕДИНЕНИЕ ВТФИООтветственныхЛиц КАК ФИООтветственныхЛиц
	               |		ПО ДанныеДокументов.Руководитель = ФИООтветственныхЛиц.ФизическоеЛицо
	               |			И ДанныеДокументов.Дата = ФИООтветственныхЛиц.Дата
	               |			И ДанныеДокументов.Ссылка = ФИООтветственныхЛиц.Ссылка
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Ссылка";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Возврат РезультатЗапроса;
	
КонецФункции

Функция ТекстСообщенияНеЗаполненВидРасчета(ВнутрисменныйОтпуск) Экспорт
	ТекстСообщения = НСтр("ru = 'Не найдено ни одного начисления для регистрации %1 отгула'");
		
	Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстСообщения, ?(ВнутрисменныйОтпуск, НСтр("ru = 'внутрисменного'") + " ", ""));	
КонецФункции

Функция ПолныеПраваНаДокумент() Экспорт 
	
	Возврат Пользователи.РолиДоступны("ДобавлениеИзменениеНачисленнойЗарплатыРасширенная, ЧтениеНачисленнойЗарплатыРасширенная", , Ложь);
	
КонецФункции	

Функция ДанныеДляПроверкиОграниченийНаУровнеЗаписей(Объект) Экспорт 

	ФизическоеЛицо = ?(ЗначениеЗаполнено(Объект.Сотрудник), ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Сотрудник, "ФизическоеЛицо"), Справочники.ФизическиеЛица.ПустаяСсылка());
	
	ДанныеДляПроверкиОграничений = ЗарплатаКадрыРасширенный.ОписаниеСтруктурыДанныхДляПроверкиОграниченийНаУровнеЗаписей();
	
	ДанныеДляПроверкиОграничений.Организация = Объект.Организация;
	ДанныеДляПроверкиОграничений.МассивФизическихЛиц = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ФизическоеЛицо);
	
	Возврат ДанныеДляПроверкиОграничений;
	
КонецФункции

Функция ДанныеДляРегистрацииВУчетаСтажаПФР(МассивСсылок) Экспорт
	ДанныеДляРегистрацииВУчете = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Отгул.Ссылка,
	|	Отгул.Сотрудник,
	|	Отгул.ВидРасчета.ВидСтажаПФР2014 КАК ВидСтажаПФР,
	|	Отгул.ДатаНачала,
	|	Отгул.ДатаОкончания,
	|	Отгул.ОтсутствиеВТечениеЧастиСмены
	|ИЗ
	|	Документ.Отгул КАК Отгул
	|ГДЕ
	|	Отгул.Ссылка В(&МассивСсылок)";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	СостояниеСотрудника = ПредопределенноеЗначение("Перечисление.СостоянияСотрудника.ДополнительныеВыходныеДниНеОплачиваемые");
	
	Пока Выборка.Следующий() Цикл
	
		ДанныеДляРегистрацииВУчетеПоДокументу = УчетСтажаПФР.ДанныеДляРегистрацииВУчетеСтажаПФР();
		ДанныеДляРегистрацииВУчете.Вставить(Выборка.Ссылка, ДанныеДляРегистрацииВУчетеПоДокументу);
		
		Если Не Выборка.ОтсутствиеВТечениеЧастиСмены Тогда		
			Если ЗначениеЗаполнено(Выборка.ВидСтажаПФР) Тогда
					
				ОписаниеПериода = УчетСтажаПФР.ОписаниеРегистрируемогоПериода();
				ОписаниеПериода.Сотрудник = Выборка.Сотрудник;	
				ОписаниеПериода.ДатаНачалаПериода = Выборка.ДатаНачала;
				ОписаниеПериода.ДатаОкончанияПериода = Выборка.ДатаОкончания;
				ОписаниеПериода.Состояние = СостояниеСотрудника;
							
				РегистрируемыйПериод = УчетСтажаПФР.ДобавитьЗаписьВДанныеДляРегистрацииВУчета(ДанныеДляРегистрацииВУчетеПоДокументу, ОписаниеПериода);

				УчетСтажаПФР.УстановитьЗначениеРегистрируемогоРесурса(РегистрируемыйПериод, "ВидСтажаПФР", Выборка.ВидСтажаПФР);
			КонецЕсли;
		КонецЕсли;	
	КонецЦикла;	

	Возврат ДанныеДляРегистрацииВУчете;
														
КонецФункции

Функция ДанныеДляПроведения(РеквизитыДляПроведения, СтруктураВидовУчета) 

	ДанныеДляПроведения = РасчетЗарплаты.СоздатьДанныеДляПроведенияНачисленияЗарплаты();
	
	Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда

		Если РеквизитыДляПроведения.ПерерасчетВыполнен Тогда
			
			РасчетЗарплатыРасширенный.ЗаполнитьНачисления(ДанныеДляПроведения, РеквизитыДляПроведения.Ссылка, "Начисления,НачисленияПерерасчет,НачисленияПерерасчетНулевыеСторно", "Ссылка.ПериодРегистрации");
			РасчетЗарплаты.ЗаполнитьСписокФизическихЛиц(ДанныеДляПроведения, РеквизитыДляПроведения.Ссылка, РеквизитыДляПроведения.ИсправленныйДокумент);
			
			ОтражениеЗарплатыВБухучете.СоздатьВТНачисленияСДаннымиЕНВД(РеквизитыДляПроведения.Организация, РеквизитыДляПроведения.ПериодРегистрации, ДанныеДляПроведения.МенеджерВременныхТаблиц, ДанныеДляПроведения.НачисленияПоСотрудникам);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если РеквизитыДляПроведения.ПерерасчетВыполнен И СтруктураВидовУчета.ДанныеДляРасчетаСреднего Тогда
		ДополнительныеПараметры = УчетСреднегоЗаработка.ДополнительныеПараметрыРегистрацииДанныхСреднегоЗаработка();
		ДополнительныеПараметры.МесяцНачисления = "Ссылка.ПериодРегистрации";
		УчетСреднегоЗаработка.ЗаполнитьТаблицыДляРегистрацииДанныхСреднегоЗаработка(ДанныеДляПроведения, РеквизитыДляПроведения.Ссылка, ДополнительныеПараметры);
	КонецЕсли;
	
	Возврат ДанныеДляПроведения;

КонецФункции

Функция ДанныеОВремени(РеквизитыДляПроведения) Экспорт	
	ДанныеОВремени = УчетРабочегоВремениРасширенный.ТаблицаДляРегистрацииВремениВнутрисменныхОтклонений();
	
	Если РеквизитыДляПроведения.ОтсутствиеВТечениеЧастиСмены Тогда
		СтрокаДанныхОВремени = ДанныеОВремени.Добавить();
		СтрокаДанныхОВремени.Дата = РеквизитыДляПроведения.ДатаОтсутствия;
		СтрокаДанныхОВремени.Сотрудник = РеквизитыДляПроведения.Сотрудник;
		СтрокаДанныхОВремени.Организация = РеквизитыДляПроведения.Организация;
		СтрокаДанныхОВремени.ВидВремени = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(РеквизитыДляПроведения.ВидРасчета, "ОбозначениеВТабелеУчетаРабочегоВремени");
		СтрокаДанныхОВремени.ВидВремениВытесняемый = РеквизитыДляПроведения.ВидВремениЗамещаемый;
		СтрокаДанныхОВремени.Часов = РеквизитыДляПроведения.КоличествоЧасовОтгула;
		СтрокаДанныхОВремени.Смена = РеквизитыДляПроведения.Смена;
		СтрокаДанныхОВремени.ПереходящаяЧастьПредыдущейСмены = РеквизитыДляПроведения.ПереходящаяЧастьПредыдущейСмены;
		СтрокаДанныхОВремени.ПереходящаяЧастьТекущейСмены = РеквизитыДляПроведения.ПереходящаяЧастьТекущейСмены;
	КонецЕсли;
	
	Возврат ДанныеОВремени;	
КонецФункции

Функция ДанныеОбОтгулах(РеквизитыДляПроведения) Экспорт

	ТаблицаОтгулов = Новый Структура("Организация, Сотрудник, Период, ВидДвижения, Дни, Часы");
	Если РеквизитыДляПроведения.ОтсутствиеВТечениеЧастиСмены Тогда
		ТаблицаОтгулов.Период = РеквизитыДляПроведения.ДатаОтсутствия;
	Иначе
		ТаблицаОтгулов.Период = РеквизитыДляПроведения.ДатаНачала;
	КонецЕсли;
	ТаблицаОтгулов.ВидДвижения = ВидДвиженияНакопления.Расход;
	ТаблицаОтгулов.Организация = РеквизитыДляПроведения.Организация;
	ТаблицаОтгулов.Сотрудник = РеквизитыДляПроведения.Сотрудник;
	ТаблицаОтгулов.Дни = РеквизитыДляПроведения.РасходДнейОтгула; 
	ТаблицаОтгулов.Часы = РеквизитыДляПроведения.РасходЧасовОтгула;

	Возврат ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ТаблицаОтгулов);
	
КонецФункции

Функция РеквизитыДляПроведения(ДокументСсылка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Отгул.Ссылка КАК Ссылка,
	|	Отгул.Дата КАК Дата,
	|	Отгул.Организация КАК Организация,
	|	Отгул.ПериодРегистрации КАК ПериодРегистрации,
	|	Отгул.ПерерасчетВыполнен КАК ПерерасчетВыполнен,
	|	Отгул.ОтсутствиеВТечениеЧастиСмены КАК ОтсутствиеВТечениеЧастиСмены,
	|	Отгул.Сотрудник КАК Сотрудник,
	|	Отгул.ДатаНачала КАК ДатаНачала,
	|	Отгул.ДатаОкончания КАК ДатаОкончания,
	|	Отгул.ОсвобождатьСтавку КАК ОсвобождатьСтавку,
	|	Отгул.ФизическоеЛицо КАК ФизическоеЛицо,
	|	Отгул.ИсправленныйДокумент КАК ИсправленныйДокумент,
	|	Отгул.ДатаОтсутствия КАК ДатаОтсутствия,
	|	Отгул.ВидРасчета КАК ВидРасчета,
	|	Отгул.ВидВремениЗамещаемый КАК ВидВремениЗамещаемый,
	|	Отгул.КоличествоЧасовОтгула КАК КоличествоЧасовОтгула,
	|	Отгул.РасходДнейОтгула КАК РасходДнейОтгула,
	|	Отгул.РасходЧасовОтгула КАК РасходЧасовОтгула,
	|	Отгул.Смена КАК Смена,
	|	Отгул.ПереходящаяЧастьПредыдущейСмены КАК ПереходящаяЧастьПредыдущейСмены,
	|	Отгул.ПереходящаяЧастьТекущейСмены КАК ПереходящаяЧастьТекущейСмены
	|ИЗ
	|	Документ.Отгул КАК Отгул
	|ГДЕ
	|	Отгул.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОтгулРаспределениеПоТерриториямУсловиямТруда.НомерСтроки КАК НомерСтроки,
	|	ОтгулРаспределениеПоТерриториямУсловиямТруда.ИдентификаторСтроки КАК ИдентификаторСтроки,
	|	ОтгулРаспределениеПоТерриториямУсловиямТруда.Территория КАК Территория,
	|	ОтгулРаспределениеПоТерриториямУсловиямТруда.УсловияТруда КАК УсловияТруда,
	|	ОтгулРаспределениеПоТерриториямУсловиямТруда.ДоляРаспределения КАК ДоляРаспределения,
	|	ОтгулРаспределениеПоТерриториямУсловиямТруда.Результат КАК Результат,
	|	ОтгулРаспределениеПоТерриториямУсловиямТруда.ИдентификаторСтрокиПоказателей КАК ИдентификаторСтрокиПоказателей,
	|	ОтгулРаспределениеПоТерриториямУсловиямТруда.РанееНачислено КАК РанееНачислено
	|ИЗ
	|	Документ.Отгул.РаспределениеПоТерриториямУсловиямТруда КАК ОтгулРаспределениеПоТерриториямУсловиямТруда
	|ГДЕ
	|	ОтгулРаспределениеПоТерриториямУсловиямТруда.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОтгулРаспределениеРезультатовНачислений.ИдентификаторСтроки КАК ИдентификаторСтроки,
	|	ОтгулРаспределениеРезультатовНачислений.Территория КАК Территория,
	|	ОтгулРаспределениеРезультатовНачислений.СтатьяФинансирования КАК СтатьяФинансирования,
	|	ОтгулРаспределениеРезультатовНачислений.СтатьяРасходов КАК СтатьяРасходов,
	|	ОтгулРаспределениеРезультатовНачислений.СпособОтраженияЗарплатыВБухучете КАК СпособОтраженияЗарплатыВБухучете,
	|	ОтгулРаспределениеРезультатовНачислений.ОблагаетсяЕНВД КАК ОблагаетсяЕНВД,
	|	СУММА(ОтгулРаспределениеРезультатовНачислений.Результат) КАК Результат,
	|	ОтгулРаспределениеРезультатовНачислений.ПодразделениеУчетаЗатрат КАК ПодразделениеУчетаЗатрат
	|ИЗ
	|	Документ.Отгул.РаспределениеРезультатовНачислений КАК ОтгулРаспределениеРезультатовНачислений
	|ГДЕ
	|	ОтгулРаспределениеРезультатовНачислений.Ссылка = &Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	ОтгулРаспределениеРезультатовНачислений.СтатьяФинансирования,
	|	ОтгулРаспределениеРезультатовНачислений.СпособОтраженияЗарплатыВБухучете,
	|	ОтгулРаспределениеРезультатовНачислений.СтатьяРасходов,
	|	ОтгулРаспределениеРезультатовНачислений.Территория,
	|	ОтгулРаспределениеРезультатовНачислений.ОблагаетсяЕНВД,
	|	ОтгулРаспределениеРезультатовНачислений.ПодразделениеУчетаЗатрат,
	|	ОтгулРаспределениеРезультатовНачислений.ИдентификаторСтроки";
	
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	Результаты = Запрос.ВыполнитьПакет();
	
	РеквизитыДляПроведения = РеквизитыДляПроведенияПустаяСтруктура();
	
	ВыборкаРеквизиты = Результаты[0].Выбрать();
	
	Пока ВыборкаРеквизиты.Следующий() Цикл
		
		ЗаполнитьЗначенияСвойств(РеквизитыДляПроведения, ВыборкаРеквизиты);
		
	КонецЦикла;
	
	РаспределениеПоТерриториямУсловиямТруда = Результаты[1].Выгрузить();
	РаспределениеРезультатовНачислений = Результаты[2].Выгрузить();
	РеквизитыДляПроведения.РаспределениеПоТерриториямУсловиямТруда = РаспределениеПоТерриториямУсловиямТруда;
	РеквизитыДляПроведения.РаспределениеРезультатовНачислений = РаспределениеРезультатовНачислений;
	
	РеквизитыДляПроведения.СотрудникиДаты = Результаты[0].Выгрузить();
	РеквизитыДляПроведения.СотрудникиДаты.Колонки.ДатаНачала.Имя = "ДатаСобытия";
	
	Возврат РеквизитыДляПроведения;
	
КонецФункции

Функция РеквизитыДляПроведенияПустаяСтруктура()
	
	РеквизитыДляПроведенияПустаяСтруктура = Новый Структура("Ссылка, Дата, Организация, ПериодРегистрации, ПерерасчетВыполнен, ОтсутствиеВТечениеЧастиСмены, Сотрудник, ДатаНачала, 
		| ДатаОкончания, ОсвобождатьСтавку, ФизическоеЛицо, ИсправленныйДокумент, ДатаОтсутствия, ВидРасчета, ВидВремениЗамещаемый, КоличествоЧасовОтгула, РасходДнейОтгула, 
		| РасходЧасовОтгула, РаспределениеПоТерриториямУсловиямТруда, Смена, ПереходящаяЧастьПредыдущейСмены, ПереходящаяЧастьТекущейСмены, РаспределениеРезультатовНачислений,СотрудникиДаты");
	
	Возврат РеквизитыДляПроведенияПустаяСтруктура;
	
КонецФункции

Процедура ПроверитьПересечениеФактическогоПериодаДействия(ДокументСсылка, Отказ)
	
	Если Отказ Тогда
		Возврат;	
	КонецЕсли;
	
	ИменаРеквизитов = 
	"ПериодРегистрации,
	|Организация,
	|ИсправленныйДокумент,
	|ВидРасчета";
	
	РеквизитыДокумента = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ДокументСсылка, ИменаРеквизитов);
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	
	Запрос.Текст = "ВЫБРАТЬ
	               |	Начисления.*
	               |ИЗ
	               |	Документ.Отгул.Начисления КАК Начисления
	               |ГДЕ
	               |	Начисления.Ссылка = &Ссылка";
				   
	Начисления = Запрос.Выполнить().Выгрузить();
	
	ПараметрыПроверки = РасчетЗарплатыРасширенный.ПараметрыПроверкиПересеченияФактическогоПериодаДействия();
	ПараметрыПроверки.Организация = РеквизитыДокумента.Организация;
	ПараметрыПроверки.ПериодРегистрации = РеквизитыДокумента.ПериодРегистрации;
	ПараметрыПроверки.Документ = ДокументСсылка;
	ПараметрыПроверки.Начисления = Начисления;
	ПараметрыПроверки.ИсправленныйДокумент = РеквизитыДокумента.ИсправленныйДокумент;
	ПараметрыПроверки.ОсновныеНачисления = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(РеквизитыДокумента.ВидРасчета);
	
	РасчетЗарплатыРасширенный.ПроверитьПересечениеФактическогоПериодаДействия(ПараметрыПроверки, Отказ);
	
КонецПроцедуры

Процедура ЗарегистрироватьВнутрисменныеОтклонения(Движения, РеквизитыДляПроведения)
	
	Если Не РеквизитыДляПроведения.ОтсутствиеВТечениеЧастиСмены Тогда
		Возврат;
	КонецЕсли;
	
	УчетРабочегоВремениРасширенный.ЗарегистрироватьВнутрисменныеОтклонения(Движения, ДанныеОВремени(РеквизитыДляПроведения), РеквизитыДляПроведения.ПериодРегистрации);
	
КонецПроцедуры

Процедура ЗарегистрироватьСторноЗаписиУчетаВремени(Движения, Сотрудник, ПериодРегистрации, ИсправленныйДокумент, Записывать = Ложь) Экспорт
	
	Если Не ЗначениеЗаполнено(ИсправленныйДокумент) Тогда
		Возврат;
	КонецЕсли;
	
	Сотрудники = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Сотрудник);
	УчетРабочегоВремениРасширенный.ЗарегистрироватьСторноЗаписиПоДокументу(Движения, ПериодРегистрации, ИсправленныйДокумент, Сотрудники, Записывать);
	
КонецПроцедуры 

Процедура ЗаполнитьИсходныеДанныеПерерасчетов(ПараметрыОбновления) Экспорт

	ПараметрыЗаполнения = ПерерасчетЗарплаты.ПараметрыЗаполненияИсходныхДанныхПерерасчетов();
	ПерерасчетЗарплаты.ЗаполнитьИсходныеДанныеПерерасчетов(ПараметрыОбновления, Метаданные.Документы.Отгул, ПараметрыЗаполнения);

КонецПроцедуры

#Область ПараметрыВыбораНачислений

Функция ДополнительныеПараметрыВыбораНачислений(Документ, ПутьКРеквизиту) Экспорт
	Результат = Новый Соответствие;
	
	Если ПутьКРеквизиту = "ВидРасчета" Тогда
		ВидыВремени = Новый Массив;
		ВидыВремени.Добавить(Перечисления.ВидыРабочегоВремениСотрудников.ВидВремениДокументовОтклонений(Документ.ОтсутствиеВТечениеЧастиСмены));
		ВидыВремени.Добавить(Перечисления.ВидыРабочегоВремениСотрудников.ДополнительноОплачиваемоеВПределахНормы);
	КонецЕсли;
	
	Результат.Вставить("Отбор.ВидВремени", ВидыВремени);
	
	Возврат Результат;
КонецФункции

#КонецОбласти

Процедура ЗаполнитьДвиженияЗанятостьПозицийШтатногоРасписания(ПараметрыОбновления = Неопределено) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.Текст =
		"ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1000
		|	ТаблицаДокумента.Ссылка КАК Регистратор,
		|	ТаблицаДокумента.Сотрудник КАК Сотрудник,
		|	ТаблицаДокумента.ДатаНачала КАК ДатаНачала,
		|	ТаблицаДокумента.ДатаОкончания КАК ДатаОкончания,
		|	ЕСТЬNULL(ТаблицаДокументаИсправления.Ссылка, ТаблицаДокументаСторнирование.Ссылка) КАК РегистраторИзмерение
		|ИЗ
		|	Документ.Отгул КАК ТаблицаДокумента
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КадроваяИсторияСотрудников КАК КадроваяИсторияСотрудников
		|		ПО ТаблицаДокумента.Сотрудник = КадроваяИсторияСотрудников.Сотрудник
		|			И (КОНЕЦПЕРИОДА(ТаблицаДокумента.ДатаНачала, ДЕНЬ) >= КадроваяИсторияСотрудников.Период)
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЗанятостьПозицийШтатногоРасписания КАК ЗанятостьПозицийШтатногоРасписания
		|		ПО ТаблицаДокумента.Ссылка = ЗанятостьПозицийШтатногоРасписания.Регистратор
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.Отгул КАК ТаблицаДокументаИсправления
		|			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЗанятостьПозицийШтатногоРасписанияИспр КАК ЗанятостьПозицийШтатногоРасписанияИспр
		|			ПО ТаблицаДокументаИсправления.Ссылка = ЗанятостьПозицийШтатногоРасписанияИспр.РегистраторИзмерение
		|		ПО ТаблицаДокумента.Ссылка = ТаблицаДокументаИсправления.ИсправленныйДокумент
		|			И (ТаблицаДокументаИсправления.Проведен)
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.СторнированиеНачислений КАК ТаблицаДокументаСторнирование
		|			ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЗанятостьПозицийШтатногоРасписанияИспр КАК ЗанятостьПозицийШтатногоРасписанияСторнирование
		|			ПО ТаблицаДокументаСторнирование.Ссылка = ЗанятостьПозицийШтатногоРасписанияСторнирование.РегистраторИзмерение
		|		ПО ТаблицаДокумента.Ссылка = ТаблицаДокументаСторнирование.СторнируемыйДокумент
		|			И (ТаблицаДокументаСторнирование.Проведен)
		|ГДЕ
		|	ТаблицаДокумента.Проведен
		|	И ТаблицаДокумента.ОсвобождатьСтавку
		|	И ЗанятостьПозицийШтатногоРасписания.Регистратор ЕСТЬ NULL
		|	И ЗанятостьПозицийШтатногоРасписанияИспр.РегистраторИзмерение ЕСТЬ NULL
		|	И ЗанятостьПозицийШтатногоРасписанияСторнирование.РегистраторИзмерение ЕСТЬ NULL
		|	И НЕ КадроваяИсторияСотрудников.Сотрудник ЕСТЬ NULL
		|
		|УПОРЯДОЧИТЬ ПО
		|	ДатаНачала,
		|	Регистратор,
		|	Сотрудник";
	
	Если ПараметрыОбновления = Неопределено Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ПЕРВЫЕ 1000", "");
	КонецЕсли;
	
	Выборка = Запрос.Выполнить().Выбрать();
	РегистрыСведений.ЗанятостьПозицийШтатногоРасписания.ЗаполнитьДвиженияПоДаннымВыборкиРегистраторов(Выборка, Ложь, ПараметрыОбновления);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
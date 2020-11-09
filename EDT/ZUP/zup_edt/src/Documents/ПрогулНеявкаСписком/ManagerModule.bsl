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
//  ДокументСсылка	- ДокументСсылка.ПрогулНеявкаСписком - Ссылка на документ
//  РежимПроведения - РежимПроведенияДокумента - Режим проведения документа (оперативный, неоперативный)
//  Отказ 			- Булево - Признак отказа от выполнения проведения
//  ВидыУчетов 		- Строка - Список видов учета, по которым необходимо провести документ. Если параметр пустой или Неопределено, то документ проведется по всем учетам
//  Движения 		- Коллекция движений документа - Передается только при вызове из обработки проведения документа
//  Объект			- ДокументОбъект.ПрогулНеявкаСписком - Передается только при вызове из обработки проведения документа
//  ДополнительныеПараметры - Структура - Дополнительные параметры, необходимые для проведения документа.
//
Процедура ПровестиПоУчетам(ДокументСсылка, РежимПроведения, Отказ, ВидыУчетов = Неопределено, Движения = Неопределено, Объект = Неопределено, ДополнительныеПараметры = Неопределено) Экспорт
	
	СтруктураВидовУчета = ПроведениеРасширенныйСервер.СтруктураВидовУчета();
	ПроведениеРасширенныйСервер.ПодготовитьНаборыЗаписейКРегистрацииДвиженийПоВидамУчета(РежимПроведения, ДокументСсылка, СтруктураВидовУчета, ВидыУчетов, Движения, Объект, Отказ);
	
	РеквизитыДляПроведения = РеквизитыДляПроведения(ДокументСсылка);
	ДанныеДляПроведения = ДанныеДляПроведения(РеквизитыДляПроведения, СтруктураВидовУчета);

	ИсправлениеДокументовЗарплатаКадры.ПриПроведенииИсправления(ДокументСсылка, Движения, РежимПроведения, Отказ, РеквизитыДляПроведения, СтруктураВидовУчета, Объект);
	
	Если РеквизитыДляПроведения.ПерерасчетВыполнен Тогда 
		
		Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда
		
			РасчетЗарплатыРасширенный.СформироватьДвиженияНачислений(
				Движения, Отказ, РеквизитыДляПроведения.Организация, КонецМесяца(РеквизитыДляПроведения.ПериодРегистрации), ДанныеДляПроведения.Начисления, ДанныеДляПроведения.ПоказателиНачислений, Истина);
				
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
			
			// - Регистрация бухучета начислений, выполняется до вызова регистрации доходов в учете НДФЛ.
			ОтражениеЗарплатыВБухучетеРасширенный.ЗарегистрироватьНачисленияУдержания(ДанныеДляПроведенияУчетЗарплаты, Отказ,
				ДанныеДляПроведения.НачисленияПоСотрудникам, Неопределено, Неопределено);
			
			ДатаОперацииПоНалогам = УчетНДФЛ.ДатаОперацииПоДокументу(РеквизитыДляПроведения.Дата, РеквизитыДляПроведения.ПериодРегистрации);
				
			УчетНДФЛРасширенный.СформироватьДоходыНДФЛПоНачислениям(Движения, Отказ, РеквизитыДляПроведения.Организация,
				ДатаОперацииПоНалогам, КонецМесяца(РеквизитыДляПроведения.ПериодРегистрации),
				ДанныеДляПроведения.МенеджерВременныхТаблиц, , , , "ВТНачисленияДляУчетаДоходовНДФЛ", ДокументСсылка);
						
			// Дополняем доходы НДФЛ сведениями о распределении по статьям финансирования и/или статьям расходов.
			ОтражениеЗарплатыВУчетеРасширенный.ДополнитьСведенияОДоходахНДФЛСведениямиОРаспределенииПоСтатьям(Движения);
			
			// - Регистрация начислений в доходах для страховых взносов.
			УчетСтраховыхВзносов.СформироватьСведенияОДоходахСтраховыеВзносы(
				Движения, Отказ, РеквизитыДляПроведения.Организация, РеквизитыДляПроведения.ПериодРегистрации, ДанныеДляПроведения.МенеджерВременныхТаблиц, Ложь, Истина, РеквизитыДляПроведения.Ссылка);
			
		КонецЕсли;
		
		Если СтруктураВидовУчета.ДанныеДляРасчетаСреднего Тогда
			
			// Учет среднего заработка
			УчетСреднегоЗаработка.ЗарегистрироватьДанныеСреднегоЗаработка(Движения, Отказ, ДанныеДляПроведения.НачисленияДляСреднегоЗаработка);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда

		ПараметрыДвиженийОтпусков = ОстаткиОтпусков.ПараметрыДляСформироватьДвиженияФактическихОтпусков();
		ПараметрыДвиженийОтпусков.ДатаРегистрации = РеквизитыДляПроведения.Дата;
		ПараметрыДвиженийОтпусков.Начисления = ДанныеДляПроведения.Начисления;
		ПараметрыДвиженийОтпусков.ПериодНачисления = РеквизитыДляПроведения.ПериодРегистрации;
		ОстаткиОтпусков.СформироватьДвиженияФактическихОтпусков(Движения, Отказ, ПараметрыДвиженийОтпусков);
		
		СостоянияСотрудников.ЗарегистрироватьСостоянияСотрудников(
			Движения, РеквизитыДляПроведения.Ссылка, ДанныеДляПроведения.ДанныеСостояний);
			
		УчетСтажаПФР.ЗарегистрироватьПериодыВУчетеСтажаПФР(Движения,
			ДанныеДляРегистрацииВУчетаСтажаПФР(РеквизитыДляПроведения.Ссылка)[РеквизитыДляПроведения.Ссылка]);	
		
		Если РеквизитыДляПроведения.ОсвобождатьСтавку Тогда
			
			ЗарплатаКадрыРасширенный.УстановитьВремяРегистрацииДокумента(Движения, РеквизитыДляПроведения.СотрудникиДаты, РеквизитыДляПроведения.Ссылка);
			КадровыйУчетРасширенный.СформироватьДвиженияЗанятостиВременноОсвобожденныхПозицииПоТаблицеЗначений(
				Движения, РеквизитыДляПроведения.Сотрудники, Ложь);
			
		КонецЕсли;
		
		ПерерасчетЗарплаты.УдалитьПерерасчетыПоДополнительнымПараметрам(РеквизитыДляПроведения.Ссылка, ДополнительныеПараметры);
		
	КонецЕсли;
	
	ПроведениеРасширенныйСервер.ВыполнитьЗапланированныеКорректировкиДвижений(Движения);
	
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
		РеквизитыДляПроведения.Вставить("Сотрудники", РеквизитыИсправленногоДокумента.Сотрудники);
	КонецЕсли;
	
	СторнироватьРасчеты = ДополнительныеПараметры.ОтменаДокумента Или РеквизитыДляПроведения.ПерерасчетВыполнен;
	
	Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда
		
		Сотрудники = РеквизитыДляПроведения.Сотрудники.ВыгрузитьКолонку("Сотрудник");
		УчетРабочегоВремениРасширенный.ЗарегистрироватьСторноЗаписиПоДокументу(Движения, РеквизитыДляПроведения.ПериодРегистрации, ИсправленныйДокумент, Сотрудники);
		УправлениеШтатнымРасписанием.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент);
		
	КонецЕсли;

	Если СторнироватьРасчеты И (ДополнительныеПараметры.ОтменаДокумента Или ДополнительныеПараметры.ИсправлениеВТекущемПериоде) Тогда
		
		Если СтруктураВидовУчета.ДанныеДляРасчетаСреднего Тогда
			УчетСреднегоЗаработка.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент);
		КонецЕсли;
		
		Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда
			УчетНДФЛРасширенный.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент, ДополнительныеПараметры);
			УчетНачисленнойЗарплатыРасширенный.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент, ДополнительныеПараметры);
			УчетСтраховыхВзносовРасширенный.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент, ДополнительныеПараметры);
			УчетСреднегоЗаработка.СторнироватьДвиженияДокумента(Движения, ИсправленныйДокумент);
			
			ИсправлениеДокументовЗарплатаКадры.СторнироватьДвиженияБезСпецификиУчетов(
				Движения, ИсправленныйДокумент,	ДополнительныеПараметры);
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
	|	И ДляВсехСтрок(ЗначениеРазрешено(Сотрудники.ФизическоеЛицо, NULL КАК ИСТИНА) )";
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает описание состава документа
//
// Возвращаемое значение:
//  Структура - см. ЗарплатаКадрыСоставДокументов.НовоеОписаниеСоставаОбъекта.
//
Функция ОписаниеСоставаОбъекта() Экспорт
	
	МетаданныеДокумента = Метаданные.Документы.ПрогулНеявкаСписком;
	Возврат ЗарплатаКадрыСоставДокументов.ОписаниеСоставаОбъектаПоМетаданнымФизическиеЛицаВТабличныхЧастях(МетаданныеДокумента);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДобавитьКомандыСозданияДокументов(КомандыСозданияДокументов, ДополнительныеПараметры) Экспорт
	
	ЗарплатаКадрыРасширенный.ДобавитьВКоллекциюКомандуСозданияДокументаПоМетаданнымДокумента(
		КомандыСозданияДокументов, Метаданные.Документы.ПрогулНеявкаСписком);
	
КонецФункции

#Область Печать

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
КонецПроцедуры

#КонецОбласти

Функция ПолныеПраваНаДокумент() Экспорт 
	
	Возврат Пользователи.РолиДоступны("ДобавлениеИзменениеНачисленнойЗарплатыРасширенная, ЧтениеНачисленнойЗарплатыРасширенная", , Ложь);
	
КонецФункции	

Функция ДанныеДляПроверкиОграниченийНаУровнеЗаписей(Объект) Экспорт 

	СписокСотрудников = ОбщегоНазначения.ВыгрузитьКолонку(Объект.Сотрудники, "Сотрудник", Истина);
	ФизическиеЛицаСотрудников = ОбщегоНазначения.ЗначениеРеквизитаОбъектов(СписокСотрудников, "ФизическоеЛицо");
	СписокФизическихЛиц = ОбщегоНазначения.ВыгрузитьКолонку(ФизическиеЛицаСотрудников, "Значение", Истина);
	
	ДанныеДляПроверкиОграничений = ЗарплатаКадрыРасширенный.ОписаниеСтруктурыДанныхДляПроверкиОграниченийНаУровнеЗаписей();
	
	ДанныеДляПроверкиОграничений.Организация = Объект.Организация;
	ДанныеДляПроверкиОграничений.МассивФизическихЛиц = СписокФизическихЛиц;
	
	Возврат ДанныеДляПроверкиОграничений;
	
КонецФункции

Функция ДанныеДляРегистрацииВУчетаСтажаПФР(МассивСсылок) Экспорт
	
	ДанныеДляРегистрацииВУчете = Новый Соответствие;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПрогулНеявкаСписком.Ссылка КАК Ссылка,
	|	ПрогулНеявкаСписком.Сотрудник КАК Сотрудник,
	|	ПрогулНеявкаСписком.Ссылка.СостояниеСотрудника КАК СостояниеСотрудника,
	|	ПрогулНеявкаСписком.Ссылка.ВидОтсутствия.ВидСтажаПФР2014 КАК ВидСтажаПФР,
	|	ПрогулНеявкаСписком.ДатаНачала КАК ДатаНачала,
	|	ПрогулНеявкаСписком.ДатаОкончания КАК ДатаОкончания,
	|	ЛОЖЬ КАК ОтсутствиеВТечениеЧастиСмены
	|ИЗ
	|	Документ.ПрогулНеявкаСписком.Сотрудники КАК ПрогулНеявкаСписком
	|ГДЕ
	|	ПрогулНеявкаСписком.Ссылка В(&МассивСсылок)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Ссылка,
	|	Сотрудник";
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.СледующийПоЗначениюПоля("Ссылка") Цикл
	
		ДанныеДляРегистрацииВУчетеПоДокументу = УчетСтажаПФР.ДанныеДляРегистрацииВУчетеСтажаПФР();
		ДанныеДляРегистрацииВУчете.Вставить(Выборка.Ссылка, ДанныеДляРегистрацииВУчетеПоДокументу);
		
		Пока Выборка.Следующий() Цикл
			
			Если ЗначениеЗаполнено(Выборка.ВидСтажаПФР) Тогда
					
				ОписаниеПериода = УчетСтажаПФР.ОписаниеРегистрируемогоПериода();
				ОписаниеПериода.Сотрудник = Выборка.Сотрудник;	
				ОписаниеПериода.ДатаНачалаПериода = Выборка.ДатаНачала;
				ОписаниеПериода.ДатаОкончанияПериода = Выборка.ДатаОкончания;
				ОписаниеПериода.Состояние = Выборка.СостояниеСотрудника;
							
				РегистрируемыйПериод = УчетСтажаПФР.ДобавитьЗаписьВДанныеДляРегистрацииВУчета(ДанныеДляРегистрацииВУчетеПоДокументу, ОписаниеПериода);

				УчетСтажаПФР.УстановитьЗначениеРегистрируемогоРесурса(РегистрируемыйПериод, "ВидСтажаПФР", Выборка.ВидСтажаПФР);
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;	

	Возврат ДанныеДляРегистрацииВУчете;
														
КонецФункции	

Функция ДанныеДляПроведения(РеквизитыДляПроведения, СтруктураВидовУчета) 

	ДанныеДляПроведения = РасчетЗарплаты.СоздатьДанныеДляПроведенияНачисленияЗарплаты();
	
	Если СтруктураВидовУчета.ОстальныеВидыУчета Тогда

		РасчетЗарплатыРасширенный.ЗаполнитьНачисления(ДанныеДляПроведения, РеквизитыДляПроведения.Ссылка, "Начисления,НачисленияПерерасчет,НачисленияПерерасчетНулевыеСторно", "Ссылка.ПериодРегистрации");
		Если РеквизитыДляПроведения.ПерерасчетВыполнен Тогда
			
			РасчетЗарплаты.ЗаполнитьСписокФизическихЛиц(ДанныеДляПроведения, РеквизитыДляПроведения.Ссылка, РеквизитыДляПроведения.ИсправленныйДокумент);
			ОтражениеЗарплатыВБухучете.СоздатьВТНачисленияСДаннымиЕНВД(РеквизитыДляПроведения.Организация, РеквизитыДляПроведения.ПериодРегистрации, ДанныеДляПроведения.МенеджерВременныхТаблиц, ДанныеДляПроведения.НачисленияПоСотрудникам);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Если РеквизитыДляПроведения.ПерерасчетВыполнен И СтруктураВидовУчета.ДанныеДляРасчетаСреднего Тогда
		ДополнительныеПараметры = УчетСреднегоЗаработка.ДополнительныеПараметрыРегистрацииДанныхСреднегоЗаработка();
		ДополнительныеПараметры.МесяцНачисления = "Ссылка.ПериодРегистрации";
		УчетСреднегоЗаработка.ЗаполнитьТаблицыДляРегистрацииДанныхСреднегоЗаработка(ДанныеДляПроведения, РеквизитыДляПроведения.Ссылка, ДополнительныеПараметры);
	КонецЕсли;
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("Ссылка", РеквизитыДляПроведения.Ссылка);
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ПрогулНеявкаСпискомСотрудники.Сотрудник КАК Сотрудник,
		|	ПрогулНеявкаСпискомСотрудники.Ссылка.СостояниеСотрудника КАК Состояние,
		|	ПрогулНеявкаСпискомСотрудники.ДатаНачала КАК Начало,
		|	ПрогулНеявкаСпискомСотрудники.ДатаОкончания КАК Окончание,
		|	ПрогулНеявкаСпискомСотрудники.Ссылка.ВидВремени КАК ВидВремени
		|ИЗ
		|	Документ.ПрогулНеявкаСписком.Сотрудники КАК ПрогулНеявкаСпискомСотрудники
		|ГДЕ
		|	ПрогулНеявкаСпискомСотрудники.Ссылка = &Ссылка";
	
	// Данные состояний
	ДанныеСостояний = Запрос.Выполнить().Выгрузить();
	ДанныеДляПроведения.Вставить("ДанныеСостояний", ДанныеСостояний);
	
	Возврат ДанныеДляПроведения;

КонецФункции

Функция РеквизитыДляПроведения(ДокументСсылка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПрогулНеявкаСписком.Ссылка КАК Ссылка,
	|	ПрогулНеявкаСписком.Организация КАК Организация,
	|	ПрогулНеявкаСписком.ПериодРегистрации КАК ПериодРегистрации,
	|	ПрогулНеявкаСписком.ПерерасчетВыполнен КАК ПерерасчетВыполнен,
	|	ПрогулНеявкаСписком.Дата КАК Дата,
	|	ПрогулНеявкаСписком.ОсвобождатьСтавку КАК ОсвобождатьСтавку,
	|	ПрогулНеявкаСписком.СостояниеСотрудника КАК СостояниеСотрудника,
	|	ПрогулНеявкаСписком.ИсправленныйДокумент КАК ИсправленныйДокумент,
	|	ПрогулНеявкаСписком.ВидОтсутствия КАК ВидОтсутствия,
	|	ПрогулНеявкаСписком.ВидВремени КАК ВидВремени,
	|	ПрогулНеявкаСписком.ВидВремениЗамещаемый КАК ВидВремениЗамещаемый
	|ИЗ
	|	Документ.ПрогулНеявкаСписком КАК ПрогулНеявкаСписком
	|ГДЕ
	|	ПрогулНеявкаСписком.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПрогулНеявкаСписком.Ссылка КАК Ссылка,
	|	ПрогулНеявкаСписком.Сотрудник КАК Сотрудник,
	|	ПрогулНеявкаСписком.ДатаНачала КАК ДатаНачала,
	|	ПрогулНеявкаСписком.ДатаОкончания КАК ДатаОкончания
	|ИЗ
	|	Документ.ПрогулНеявкаСписком.Сотрудники КАК ПрогулНеявкаСписком
	|ГДЕ
	|	ПрогулНеявкаСписком.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПрогулНеявкаРаспределениеПоТерриториямУсловиямТруда.НомерСтроки КАК НомерСтроки,
	|	ПрогулНеявкаРаспределениеПоТерриториямУсловиямТруда.ИдентификаторСтроки КАК ИдентификаторСтроки,
	|	ПрогулНеявкаРаспределениеПоТерриториямУсловиямТруда.Территория КАК Территория,
	|	ПрогулНеявкаРаспределениеПоТерриториямУсловиямТруда.УсловияТруда КАК УсловияТруда,
	|	ПрогулНеявкаРаспределениеПоТерриториямУсловиямТруда.ДоляРаспределения КАК ДоляРаспределения,
	|	ПрогулНеявкаРаспределениеПоТерриториямУсловиямТруда.Результат КАК Результат,
	|	ПрогулНеявкаРаспределениеПоТерриториямУсловиямТруда.ИдентификаторСтрокиПоказателей КАК ИдентификаторСтрокиПоказателей,
	|	ПрогулНеявкаРаспределениеПоТерриториямУсловиямТруда.РанееНачислено КАК РанееНачислено
	|ИЗ
	|	Документ.ПрогулНеявкаСписком.РаспределениеПоТерриториямУсловиямТруда КАК ПрогулНеявкаРаспределениеПоТерриториямУсловиямТруда
	|ГДЕ
	|	ПрогулНеявкаРаспределениеПоТерриториямУсловиямТруда.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.ИдентификаторСтроки КАК ИдентификаторСтроки,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.Территория КАК Территория,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.СтатьяФинансирования КАК СтатьяФинансирования,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.СтатьяРасходов КАК СтатьяРасходов,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.СпособОтраженияЗарплатыВБухучете КАК СпособОтраженияЗарплатыВБухучете,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.ОблагаетсяЕНВД КАК ОблагаетсяЕНВД,
	|	СУММА(ПрогулНеявкаРаспределениеРезультатовНачислений.Результат) КАК Результат,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.ПодразделениеУчетаЗатрат КАК ПодразделениеУчетаЗатрат
	|ИЗ
	|	Документ.ПрогулНеявкаСписком.РаспределениеРезультатовНачислений КАК ПрогулНеявкаРаспределениеРезультатовНачислений
	|ГДЕ
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.Ссылка = &Ссылка
	|
	|СГРУППИРОВАТЬ ПО
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.СпособОтраженияЗарплатыВБухучете,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.СтатьяРасходов,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.СтатьяФинансирования,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.Территория,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.ПодразделениеУчетаЗатрат,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.ОблагаетсяЕНВД,
	|	ПрогулНеявкаРаспределениеРезультатовНачислений.ИдентификаторСтроки";
	
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	Результаты = Запрос.ВыполнитьПакет();
	
	РеквизитыДляПроведения = РеквизитыДляПроведенияПустаяСтруктура();
	
	ВыборкаРеквизиты = Результаты[0].Выбрать();
	ВыборкаРеквизиты.Следующий();
	
	ЗаполнитьЗначенияСвойств(РеквизитыДляПроведения, ВыборкаРеквизиты);
	РеквизитыДляПроведения.Сотрудники = Результаты[1].Выгрузить();
	
	РаспределениеПоТерриториямУсловиямТруда = Результаты[2].Выгрузить();
	РаспределениеРезультатовНачислений = Результаты[3].Выгрузить();
	РеквизитыДляПроведения.РаспределениеПоТерриториямУсловиямТруда = РаспределениеПоТерриториямУсловиямТруда;
	РеквизитыДляПроведения.РаспределениеРезультатовНачислений = РаспределениеРезультатовНачислений;
	
	РеквизитыДляПроведения.СотрудникиДаты = Результаты[1].Выгрузить();
	РеквизитыДляПроведения.СотрудникиДаты.Колонки.ДатаНачала.Имя = "ДатаСобытия";
	
	Возврат РеквизитыДляПроведения;
	
КонецФункции

Функция РеквизитыДляПроведенияПустаяСтруктура()
	
	Результат = Новый Структура(
		"Ссылка,
		|Организация,
		|ПериодРегистрации,
		|ПерерасчетВыполнен,
		|Дата,
		|Сотрудники,
		|ИсправленныйДокумент,
		|ОсвобождатьСтавку,
		|СостояниеСотрудника,
		|ВидОтсутствия,
		|ВидВремени,
		|ВидВремениЗамещаемый,
		|ЧасовОтсутствия,
		|РаспределениеПоТерриториямУсловиямТруда,
		|РаспределениеРезультатовНачислений,
		|СотрудникиДаты");
	
	Возврат Результат;
	
КонецФункции

Процедура ПроверитьПересечениеФактическогоПериодаДействия(ДокументСсылка, Отказ)
	
	Если Отказ Тогда
		Возврат;	
	КонецЕсли;
	
	ИменаРеквизитов = 
		"ПериодРегистрации,
		|Организация,
		|ИсправленныйДокумент,
		|ВидОтсутствия";
	
	РеквизитыДокумента = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ДокументСсылка, ИменаРеквизитов);
	
	Запрос = Новый Запрос(
		"ВЫБРАТЬ
	    |	Начисления.*
		|ИЗ
		|	Документ.ПрогулНеявкаСписком.Начисления КАК Начисления
		|ГДЕ
		|	Начисления.Ссылка = &Ссылка");
	
	Запрос.УстановитьПараметр("Ссылка", ДокументСсылка);
	Начисления = Запрос.Выполнить().Выгрузить();
	
	ПараметрыПроверки = РасчетЗарплатыРасширенный.ПараметрыПроверкиПересеченияФактическогоПериодаДействия();
	ПараметрыПроверки.Организация = РеквизитыДокумента.Организация;
	ПараметрыПроверки.ПериодРегистрации = РеквизитыДокумента.ПериодРегистрации;
	ПараметрыПроверки.Документ = ДокументСсылка;
	ПараметрыПроверки.Начисления = Начисления;
	ПараметрыПроверки.ИсправленныйДокумент = РеквизитыДокумента.ИсправленныйДокумент;
	ПараметрыПроверки.ОсновныеНачисления = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(РеквизитыДокумента.ВидОтсутствия);
	
	РасчетЗарплатыРасширенный.ПроверитьПересечениеФактическогоПериодаДействия(ПараметрыПроверки, Отказ);
	
КонецПроцедуры

#Область ПараметрыВыбораНачислений

Функция ДополнительныеПараметрыВыбораНачислений(Документ, ПутьКРеквизиту) Экспорт
	Результат = Новый Соответствие;
	
	Если ПутьКРеквизиту = "ВидОтсутствия" Тогда
		Категория = Перечисления.КатегорииНачисленийИНеоплаченногоВремени.КатегорияПоСостояниюСотрудника(Документ.СостояниеСотрудника);
		ВидВремени = Перечисления.ВидыРабочегоВремениСотрудников.ВидВремениДокументовОтклонений(Ложь);
	КонецЕсли;
	
	Результат.Вставить("Отбор.КатегорияНачисленияИлиНеоплаченногоВремени", Категория);
	Результат.Вставить("Отбор.ВидВремени", ВидВремени);
	
	Возврат Результат;
КонецФункции

#КонецОбласти

Процедура ЗаполнитьДвиженияЗанятостьПозицийШтатногоРасписания(ПараметрыОбновления = Неопределено) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	
	Запрос.Текст =
		"ВЫБРАТЬ РАЗЛИЧНЫЕ ПЕРВЫЕ 1000
		|	ТаблицаДокумента.Ссылка КАК Регистратор
		|ПОМЕСТИТЬ ВТРегистраторыКОбновлению
		|ИЗ
		|	Документ.ПрогулНеявкаСписком.Сотрудники КАК ТаблицаДокумента
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.КадроваяИсторияСотрудников КАК КадроваяИсторияСотрудников
		|		ПО ТаблицаДокумента.Сотрудник = КадроваяИсторияСотрудников.Сотрудник
		|			И (КОНЕЦПЕРИОДА(ТаблицаДокумента.ДатаНачала, ДЕНЬ) >= КадроваяИсторияСотрудников.Период)
		|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ЗанятостьПозицийШтатногоРасписания КАК ЗанятостьПозицийШтатногоРасписания
		|		ПО ТаблицаДокумента.Ссылка = ЗанятостьПозицийШтатногоРасписания.Регистратор
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПрогулНеявкаСписком КАК ТаблицаДокументаИсправления
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
		|	ТаблицаДокумента.Ссылка.Проведен
		|	И ТаблицаДокумента.Ссылка.ОсвобождатьСтавку
		|	И ЗанятостьПозицийШтатногоРасписания.Регистратор ЕСТЬ NULL
		|	И ЗанятостьПозицийШтатногоРасписанияИспр.РегистраторИзмерение ЕСТЬ NULL
		|	И ЗанятостьПозицийШтатногоРасписанияСторнирование.РегистраторИзмерение ЕСТЬ NULL
		|	И НЕ КадроваяИсторияСотрудников.Сотрудник ЕСТЬ NULL
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ ПЕРВЫЕ 1
		|	РегистраторыКОбновлению.Регистратор КАК Регистратор
		|ИЗ
		|	ВТРегистраторыКОбновлению КАК РегистраторыКОбновлению";
	
	Если ПараметрыОбновления = Неопределено Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ПЕРВЫЕ 1000", "");
	КонецЕсли;
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		
		ОбновлениеИнформационнойБазыЗарплатаКадрыБазовый.ЗавершитьОбработчик(ПараметрыОбновления);
		Возврат;
		
	КонецЕсли;
	
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ТаблицаДокумента.Ссылка КАК Регистратор,
		|	ТаблицаДокумента.Сотрудник КАК Сотрудник,
		|	ТаблицаДокумента.ДатаНачала КАК ДатаНачала,
		|	ТаблицаДокумента.ДатаОкончания КАК ДатаОкончания,
		|	ЕСТЬNULL(ТаблицаДокументаИсправления.Ссылка, ТаблицаДокументаСторнирование.Ссылка) КАК РегистраторИзмерение
		|ИЗ
		|	ВТРегистраторыКОбновлению КАК РегистраторыКОбновлению
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПрогулНеявкаСписком.Сотрудники КАК ТаблицаДокумента
		|			ЛЕВОЕ СОЕДИНЕНИЕ Документ.ПрогулНеявкаСписком КАК ТаблицаДокументаИсправления
		|			ПО ТаблицаДокумента.Ссылка = ТаблицаДокументаИсправления.ИсправленныйДокумент
		|				И (ТаблицаДокументаИсправления.Проведен)
		|			ЛЕВОЕ СОЕДИНЕНИЕ Документ.СторнированиеНачислений КАК ТаблицаДокументаСторнирование
		|			ПО ТаблицаДокумента.Ссылка = ТаблицаДокументаСторнирование.СторнируемыйДокумент
		|				И (ТаблицаДокументаСторнирование.Проведен)
		|		ПО РегистраторыКОбновлению.Регистратор = ТаблицаДокумента.Ссылка
		|
		|УПОРЯДОЧИТЬ ПО
		|	ДатаНачала,
		|	Регистратор,
		|	Сотрудник";
	
	Выборка = Запрос.Выполнить().Выбрать();
	РегистрыСведений.ЗанятостьПозицийШтатногоРасписания.ЗаполнитьДвиженияПоДаннымВыборкиРегистраторов(Выборка, Ложь, ПараметрыОбновления);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
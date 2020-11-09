
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Для нового объекта выполняем код инициализации формы в ПриСозданииНаСервере.
	// Для существующего - в ПриЧтенииНаСервере.
	Если Объект.Ссылка.Пустая() Тогда
		ИнициализацияФормы();
	КонецЕсли;
	
	ТекущийПользователь = Пользователи.ТекущийПользователь();
	
	Ссылка = Объект.Ссылка;
	Если Ссылка.Пустая() Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьВидимостьЭлементовОтвета(ЭтаФорма);
	УстановитьВидимостьПрисоединенныхФайлов(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	БизнесПроцессыИЗадачиКлиент.ОбновитьДоступностьКомандПринятияКИсполнению(ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ВыполнитьЗадачу = Ложь;
	Если НЕ (ПараметрыЗаписи.Свойство("ВыполнитьЗадачу", ВыполнитьЗадачу) И ВыполнитьЗадачу) Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ЗаданиеВыполнено И НЕ ЗначениеЗаполнено(ТекущийОбъект.РезультатВыполнения) Тогда
		ОбщегоНазначения.СообщитьПользователю(
			НСтр("ru = 'Укажите причину, по которой задача отклоняется.'"),,
			"Объект.РезультатВыполнения",,
			Отказ);
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ЗаписатьРеквизитыБизнесПроцесса(ТекущийОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	БизнесПроцессыИЗадачиКлиент.ФормаЗадачиОбработкаОповещения(ЭтотОбъект, ИмяСобытия, Параметр, Источник);
	Если ИмяСобытия = "Запись_Задание" Тогда
		Если (Источник = Объект.БизнесПроцесс ИЛИ (ТипЗнч(Источник) = Тип("Массив") 
			И Источник.Найти(Объект.БизнесПроцесс) <> Неопределено)) Тогда
			Прочитать();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ИнициализацияФормы();
	
	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СрокНачалаИсполненияПриИзменении(Элемент)
	
	Если Объект.ДатаНачала = НачалоДня(Объект.ДатаНачала) Тогда
		Объект.ДатаНачала = КонецДня(Объект.ДатаНачала);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаИсполненияПриИзменении(Элемент)
	
	Если Объект.ДатаИсполнения = НачалоДня(Объект.ДатаИсполнения) Тогда
		Объект.ДатаИсполнения = КонецДня(Объект.ДатаИсполнения);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьИЗакрытьВыполнить()
	
	БизнесПроцессыИЗадачиКлиент.ЗаписатьИЗакрытьВыполнить(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПредметНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПоказатьЗначение(,Объект.Предмет);
	
КонецПроцедуры

&НаКлиенте
Процедура ПредставлениеФайлаОтветаНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьПрисоединенныйФайл(ФайлОтвета);
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьФайлНажатие(Элемент)
	
	УдалитьПрисоединенныйФайл();
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ФайлНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьПрисоединенныйФайл(ЭтаФорма[Элемент.Имя]);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыполненоВыполнить(Команда)
	
	Если Задание.ТипЗаявки = ПредопределенноеЗначение("Перечисление.ТипыЗаявокКабинетСотрудника.СправкаНДФЛ") И Не ДокументыЗадачиПроведены() Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Необходимо провести все документы, связанные с задачей.'"));
		Возврат;
	КонецЕсли;
	
	Задание.СостояниеЗаявки = ПредопределенноеЗначение("Перечисление.СостоянияЗаявокКабинетСотрудника.Выполнена");
	ЗаданиеВыполнено = Истина;
	БизнесПроцессыИЗадачиКлиент.ЗаписатьИЗакрытьВыполнить(ЭтотОбъект, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура Отменено(Команда)
	
	ЗаданиеВыполнено = Ложь;
	БизнесПроцессыИЗадачиКлиент.ЗаписатьИЗакрытьВыполнить(ЭтотОбъект, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура Отказать(Команда)
	
	Задание.СостояниеЗаявки = ПредопределенноеЗначение("Перечисление.СостоянияЗаявокКабинетСотрудника.Отказ");
	ЗаданиеВыполнено = Истина;
	БизнесПроцессыИЗадачиКлиент.ЗаписатьИЗакрытьВыполнить(ЭтотОбъект, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура Дополнительно(Команда)
	
	БизнесПроцессыИЗадачиКлиент.ОткрытьДопИнформациюОЗадаче(Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура ПринятьКИсполнению(Команда)
	
	БизнесПроцессыИЗадачиКлиент.ПринятьЗадачуКИсполнению(ЭтотОбъект, ТекущийПользователь);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтменитьПринятиеКИсполнению(Команда)
	
	БизнесПроцессыИЗадачиКлиент.ОтменитьПринятиеЗадачиКИсполнению(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьЗадание(Команда)
	
	Если Модифицированность Тогда
		Записать();
	КонецЕсли;	
	ПоказатьЗначение(,Объект.БизнесПроцесс);
	
КонецПроцедуры

&НаКлиенте
Процедура ШаблонОтвета(Команда)

	ПараметрыФормыВыбора = Новый Структура;
	ПараметрыФормыВыбора.Вставить("МножественныйВыбор", Ложь);
	Отбор = Новый Структура;
	Отбор.Вставить("ТипЗаявки", Задание.ТипЗаявки);
	ПараметрыФормыВыбора.Вставить("Отбор", Отбор);
	
	Оповещение = Новый ОписаниеОповещения("ПослеВыбораШаблона", ЭтотОбъект);

	ОткрытьФорму("Справочник.ШаблоныОтветовНаЗаявкиКабинетСотрудника.ФормаВыбора", ПараметрыФормыВыбора,,,,, Оповещение);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьФайлОтвета(Команда)
	
	Обработчик = Новый ОписаниеОповещения("ВыбратьФайлОтветаПослеПомещенияФайла", ЭтотОбъект);
	
	ПараметрыЗагрузки = ФайловаяСистемаКлиент.ПараметрыЗагрузкиФайла();
	ПараметрыЗагрузки.Диалог.Фильтр = НСтр("ru = 'Файлы MS Word (*.doc;*.docx)|*.doc;*.docx|Файлы PDF(*.pdf;*.PDF)|*.pdf;*.PDF'");

	ПараметрыЗагрузки.ИдентификаторФормы = УникальныйИдентификатор;

	ФайловаяСистемаКлиент.ЗагрузитьФайл(Обработчик, ПараметрыЗагрузки);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ИнициализацияФормы()
	
	НачальныйПризнакВыполнения = Объект.Выполнена;
	ПрочитатьРеквизитыБизнесПроцесса();
	УстановитьСостояниеЭлементов();
	
	ИспользоватьДатуИВремяВСрокахЗадач = ПолучитьФункциональнуюОпцию("ИспользоватьДатуИВремяВСрокахЗадач");
	Элементы.СрокНачалаИсполненияВремя.Видимость = ИспользоватьДатуИВремяВСрокахЗадач;
	Элементы.ДатаИсполненияВремя.Видимость = ИспользоватьДатуИВремяВСрокахЗадач;
	БизнесПроцессыИЗадачиСервер.УстановитьФорматДаты(Элементы.СрокИсполнения);
	БизнесПроцессыИЗадачиСервер.УстановитьФорматДаты(Элементы.Дата);
	
	БизнесПроцессыИЗадачиСервер.ФормаЗадачиПриСозданииНаСервере(ЭтотОбъект, Объект,
		Элементы.ГруппаСостояние, Элементы.ДатаИсполнения);
	Элементы.ОписаниеРезультата.ТолькоПросмотр = Объект.Выполнена;
	Элементы.Комментарий.ТолькоПросмотр = Объект.Выполнена;
	
	Элементы.ИзменитьЗадание.Видимость = (Объект.Автор = Пользователи.ТекущийПользователь());
	Исполнитель = ?(ЗначениеЗаполнено(Объект.Исполнитель), Объект.Исполнитель, Объект.РольИсполнителя);
	
	Если ПравоДоступа("Изменение", Метаданные.БизнесПроцессы.Задание) Тогда
		Элементы.Выполнено.Доступность = Истина;
		Элементы.Отказать.Доступность  = Истина;
		Элементы.Отклонено.Доступность = Истина;
	Иначе
		Элементы.Выполнено.Доступность = Ложь;
		Элементы.Отказать.Доступность  = Ложь;
		Элементы.Отклонено.Доступность = Ложь;
	КонецЕсли;
	
	ОтказДоступен = Задание.ПричинаОтсутствия = Перечисления.ПричиныОтсутствийЗаявокКабинетСотрудника.Отпуск
		Или Задание.ПричинаОтсутствия = Перечисления.ПричиныОтсутствийЗаявокКабинетСотрудника.УчебныйОтпуск
		Или Задание.ПричинаОтсутствия = Перечисления.ПричиныОтсутствийЗаявокКабинетСотрудника.ОтпускЗаСвойСчет
		Или Задание.ПричинаОтсутствия = Перечисления.ПричиныОтсутствийЗаявокКабинетСотрудника.Отгул
		Или Задание.ПричинаОтсутствия = Перечисления.ПричиныОтсутствийЗаявокКабинетСотрудника.ЛичныеДела;
	
	Элементы.Отказать.Видимость = ОтказДоступен;
	
	ФайлОтвета = Задание.ФайлОтвета;
	Если ЗначениеЗаполнено(ФайлОтвета) Тогда
		РеквизитыФайлаОтвета = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ФайлОтвета,"Наименование,Расширение,Размер");
		ПредставлениеФайлаОтвета = СтрШаблон("%1.%2 (%3)", РеквизитыФайлаОтвета.Наименование, РеквизитыФайлаОтвета.Расширение, РазмерФайлаСтрокой(РеквизитыФайлаОтвета.Размер));
		Элементы.ПредставлениеФайлаОтвета.Гиперссылка = Истина;
	КонецЕсли;
	
	ДобавляемыеРеквизиты = Новый Массив;
	ЗначенияРеквизитов = Новый Структура;
	Счетчик = 1;
	Для каждого СтрокаТЧ Из Задание.ФайлыЗаявки Цикл
		ИмяРеквизита = "ПрисоединенныйФайл" + Счетчик;
		Если Элементы.Найти(ИмяРеквизита) = Неопределено Тогда
			НовыйЭлемент = Элементы.Добавить(ИмяРеквизита, Тип("ДекорацияФормы"), Элементы.ГруппаФайлы);
			НовыйЭлемент.Вид = ВидДекорацииФормы.Надпись;
			НовыйЭлемент.Гиперссылка = Истина;
			НовыйЭлемент.Заголовок = ОбщегоНазначения.ПредметСтрокой(СтрокаТЧ.Файл);
			НовыйЭлемент.УстановитьДействие("Нажатие", "Подключаемый_ФайлНажатие");
			Реквизит = Новый РеквизитФормы(ИмяРеквизита, Новый ОписаниеТипов("СправочникСсылка.ФизическиеЛицаПрисоединенныеФайлы"));
			ДобавляемыеРеквизиты.Добавить(Реквизит);
			ЗначенияРеквизитов.Вставить(ИмяРеквизита, СтрокаТЧ.Файл);
		КонецЕсли;
		Счетчик = Счетчик + 1;
	КонецЦикла;
	Если ДобавляемыеРеквизиты.Количество() > 0 Тогда
		ИзменитьРеквизиты(ДобавляемыеРеквизиты);
		ЗаполнитьЗначенияСвойств(ЭтаФорма, ЗначенияРеквизитов);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьРеквизитыБизнесПроцесса()
	
	ЗадачаОбъект = РеквизитФормыВЗначение("Объект");
	
	УстановитьПривилегированныйРежим(Истина);
	ЗаданиеОбъект = ЗадачаОбъект.БизнесПроцесс.ПолучитьОбъект();
	ЗначениеВРеквизитФормы(ЗаданиеОбъект, "Задание");
	ЗаданиеВыполнено 			= Задание.Выполнено;
	ЗаданиеСодержание 			= Задание.Содержание;
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьРеквизитыБизнесПроцесса(ЗадачаОбъект)
	
	Если ЗначениеЗаполнено(АдресХранилищаФайлаОтвета) Тогда
		ПараметрыФайла = Новый Структура;
		ПараметрыФайла.Вставить("Автор", Пользователи.ТекущийПользователь());
		ПараметрыФайла.Вставить("ВладелецФайлов", Задание.ФизическоеЛицо);
		ПараметрыФайла.Вставить("ИмяБезРасширения", ИмяФайлаОтветаБезРасширения);
		ПараметрыФайла.Вставить("РасширениеБезТочки", РасширениеФайлаОтветаБезТочки);
		ПараметрыФайла.Вставить("ВремяИзмененияУниверсальное", ТекущаяУниверсальнаяДата());
		ПараметрыФайла.Вставить("Служебный", Истина);
		УстановитьПривилегированныйРежим(Истина);
		Задание.ФайлОтвета = РаботаСФайлами.ДобавитьФайл(ПараметрыФайла, АдресХранилищаФайлаОтвета);
		УстановитьПривилегированныйРежим(Ложь);
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	БизнесПроцессыИЗадачиСервер.ЗаблокироватьБизнесПроцессы(ЗадачаОбъект.БизнесПроцесс);
	БизнесПроцессОбъект = ЗадачаОбъект.БизнесПроцесс.ПолучитьОбъект();
	ЗаблокироватьДанныеДляРедактирования(БизнесПроцессОбъект.Ссылка);
	БизнесПроцессОбъект.Выполнено = ЗаданиеВыполнено;
	БизнесПроцессОбъект.СостояниеЗаявки = Задание.СостояниеЗаявки;
	Если Задание.ТипЗаявки = Перечисления.ТипыЗаявокКабинетСотрудника.ЗаявлениеНаОтпуск
		И Задание.СостояниеЗаявки = Перечисления.СостоянияЗаявокКабинетСотрудника.Выполнена Тогда
		БизнесПроцессОбъект.ОтпускСогласован = Истина;
	КонецЕсли;
	БизнесПроцессОбъект.ОтветПоЗаявке = Задание.ОтветПоЗаявке;
	БизнесПроцессОбъект.ФайлОтвета = Задание.ФайлОтвета;
	БизнесПроцессОбъект.Записать(); // АПК:1327 Блокировка установлена в БизнесПроцессыИЗадачиСервер.ЗаблокироватьБизнесПроцессы

КонецПроцедуры

&НаСервере
Процедура УстановитьСостояниеЭлементов()
	
	БизнесПроцессы.Задание.УстановитьСостояниеЭлементовФормыЗадачи(ЭтотОбъект);
	
КонецПроцедуры	

&НаКлиенте
Процедура ВыбратьФайлОтветаПослеПомещенияФайла(ПомещенныйФайл, ДополнительныеПараметры) Экспорт
	
	Если ПомещенныйФайл = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИмяФайла = ПомещенныйФайл.Имя;
	
	Позиция = СтрНайти(ИмяФайла, "\");
	Пока Позиция > 0 Цикл
		ИмяФайла = Прав(ИмяФайла, СтрДлина(ИмяФайла) - Позиция);
		Позиция = СтрНайти(ИмяФайла, "\");
	КонецЦикла;
	
	Позиция = СтрНайти(ИмяФайла, ".");
	Если Позиция > 0 Тогда
		ИмяФайлаОтветаБезРасширения = Лев(ИмяФайла, Позиция - 1);
		РасширениеФайлаОтветаБезТочки = Прав(ИмяФайла, СтрДлина(ИмяФайла) - Позиция);
	Иначе
		ИмяФайлаОтветаБезРасширения = ИмяФайла;
		РасширениеФайлаОтветаБезТочки = "";
	КонецЕсли;
	
	Данные = ПолучитьИзВременногоХранилища(ПомещенныйФайл.Хранение);
	
	Если Данные.Размер() > 5242880 Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Сервис не может принять файлы размером более 5Мб. Выберите другой файл.'"));
		Возврат;
	КонецЕсли;
	
	ПредставлениеФайлаОтвета = СтрШаблон("%1 (%2)", ИмяФайла, РазмерФайлаСтрокой(Данные.Размер()));
	АдресХранилищаФайлаОтвета = ПомещенныйФайл.Хранение;
	
	УстановитьВидимостьПрисоединенныхФайлов(ЭтаФорма);
	
КонецПроцедуры

// Принимает размер в байтах.
// Возвращает строку, например: 7.2 Кбайт, 35 Кбайт, 5.5 Мбайт, 12 Мбайт
&НаКлиентеНаСервереБезКонтекста
Функция РазмерФайлаСтрокой(Размер)
	
	Если Размер = 0 Тогда
		Возврат "-";
	ИначеЕсли Размер < 1024 * 10 Тогда // < 10 Кб
		Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = '%1 Кб'"),
			Формат(Макс(1, Окр(Размер / 1024, 1, 1)), "ЧГ=0"));
	ИначеЕсли Размер < 1024 * 1024 Тогда // < 1 Мб
		Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = '%1 Кб'"),
			Формат(Цел(Размер / 1024), "ЧГ=0"));
	ИначеЕсли Размер < 1024 * 1024 * 10 Тогда // < 10 Мб
		Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = '%1 Мб'"),
			Формат(Окр(Размер / 1024 / 1024, 1, 1), "ЧГ=0"));
	Иначе // >= 10 Мб
		Возврат СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = '%1 Мб'"),
			Формат(Цел(Размер / 1024 / 1024), "ЧГ=0"));
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ОткрытьПрисоединенныйФайл(ПрисоединенныйФайл)
	
	ДанныеФайла = ДанныеФайлаНаСервере(ПрисоединенныйФайл, УникальныйИдентификатор);
	РаботаСФайламиКлиент.ОткрытьФайл(ДанныеФайла, Ложь);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДанныеФайлаНаСервере(ПрисоединенныйФайл, УникальныйИдентификатор)
	
	ДополнительныеПараметры = РаботаСФайламиКлиентСервер.ПараметрыДанныхФайла();
	ДополнительныеПараметры.ИдентификаторФормы = УникальныйИдентификатор;
	Возврат РаботаСФайлами.ДанныеФайла(ПрисоединенныйФайл, ДополнительныеПараметры);

КонецФункции

&НаКлиенте
Процедура УдалитьПрисоединенныйФайл()
	
	Модифицированность = Истина;
	ФайлОтвета = Неопределено;
	РасширениеФайлаОтветаБезТочки = "";
	ПредставлениеФайлаОтвета = "";
	АдресХранилищаФайлаОтвета = "";
	УстановитьВидимостьПрисоединенныхФайлов(ЭтаФорма);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьЭлементовОтвета(Форма)
	
	Если (Форма.Задание.ТипЗаявки = ПредопределенноеЗначение("Перечисление.ТипыЗаявокКабинетСотрудника.СправкаСМестаРаботы")
		Или Форма.Задание.ТипЗаявки = ПредопределенноеЗначение("Перечисление.ТипыЗаявокКабинетСотрудника.СправкаОбОстаткеОтпуска")
		Или Форма.Задание.ТипЗаявки = ПредопределенноеЗначение("Перечисление.ТипыЗаявокКабинетСотрудника.СправкаНДФЛ")) Тогда
		Форма.Элементы.ГруппаОтвет.Видимость = Истина;
	Иначе
		Форма.Элементы.ГруппаОтвет.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьВидимостьПрисоединенныхФайлов(Форма)
	
	Если (Форма.Задание.ТипЗаявки = ПредопределенноеЗначение("Перечисление.ТипыЗаявокКабинетСотрудника.СправкаСМестаРаботы")
		Или Форма.Задание.ТипЗаявки = ПредопределенноеЗначение("Перечисление.ТипыЗаявокКабинетСотрудника.СправкаОбОстаткеОтпуска")) Тогда
		Форма.Элементы.ГруппаПрисоединитьФайл.Видимость = Истина;
		
		Форма.Элементы.ВыбратьФайл.Видимость = Не ЗначениеЗаполнено(Форма.ПредставлениеФайлаОтвета);
		Форма.Элементы.КартинкаУдалитьФайл.Видимость = ЗначениеЗаполнено(Форма.ПредставлениеФайлаОтвета);
		Форма.Элементы.ПредставлениеФайлаОтвета.Видимость = ЗначениеЗаполнено(Форма.ПредставлениеФайлаОтвета);

	Иначе
		Форма.Элементы.ГруппаПрисоединитьФайл.Видимость = Ложь;
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Функция ДокументыЗадачиПроведены()
	
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Задание.Предмет, "Проведен");
	
КонецФункции

&НаКлиенте
Процедура ПослеВыбораШаблона(Результат, Параметры) Экспорт
	
	Если Не ЗначениеЗаполнено(Результат) Тогда
		Возврат;
	КонецЕсли;
	Задание.ОтветПоЗаявке = ПослеВыбораШаблонаНаСервере(Результат);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПослеВыбораШаблонаНаСервере(ШаблонОтвета)

	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ШаблонОтвета, "ТекстОтвета");

КонецФункции



#КонецОбласти


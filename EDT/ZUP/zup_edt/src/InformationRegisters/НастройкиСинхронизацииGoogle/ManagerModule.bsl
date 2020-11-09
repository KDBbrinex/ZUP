#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает структру с ключами, соответствующими ресурсам регистра сведений НастройкиСинхронизацииGoogle
//
// Возвращаемое значение:
//  Структура - ключи соответствуют ресурсам регистра НастройкиСинхронизацииGoogle
//   * ТокенДоступа		- Строка - access_token
//   * ТипТокенаДоступа	- Строка - token_type
//   * ТокенОбновления 	- Строка - refresh_token
//
Функция НовыеДанныеАвторизации() Экспорт

	ДанныеАвторизации = Новый Структура;
	ДанныеАвторизации.Вставить("ТокенДоступа",  	""); //access_token
	ДанныеАвторизации.Вставить("ТипТокенаДоступа",	""); //token_type
	ДанныеАвторизации.Вставить("ТокенОбновления", 	""); //refresh_token
	Возврат ДанныеАвторизации;

КонецФункции

// Возвращает данные, записанные в регистре сведений НастройкиСинхронизацииGoogle
//
// Параметры:
//	Узел - ПланОбменаСсылка.СинхронизацияКалендарей - узел пользователя, для которого требуется доступ
//
// Возвращаемое значение:
//  Структура - ключи соответствуют ресурсам регистра НастройкиСинхронизацииGoogle
//   * ТокенДоступа		- Строка - access_token
//   * ТипТокенаДоступа	- Строка - token_type
//   * ТокенОбновления 	- Строка - refresh_token
//
Функция ДанныеАвторизации(Узел) Экспорт

	УстановитьПривилегированныйРежим(Истина);
	Результат = НовыеДанныеАвторизации();
	Запрос = Новый Запрос(
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	НастройкиСинхронизацииGoogle.ТокенДоступа КАК ТокенДоступа,
	|	НастройкиСинхронизацииGoogle.ТипТокенаДоступа КАК ТипТокенаДоступа,
	|	НастройкиСинхронизацииGoogle.ТокенОбновления КАК ТокенОбновления
	|ИЗ
	|	РегистрСведений.НастройкиСинхронизацииGoogle КАК НастройкиСинхронизацииGoogle
	|ГДЕ
	|	НастройкиСинхронизацииGoogle.Узел = &Узел");
	Запрос.УстановитьПараметр("Узел", Узел);
	РезультатЗапроса = Запрос.Выполнить();
	Если Не РезультатЗапроса.Пустой() Тогда
		Выборка = РезультатЗапроса.Выбрать();
		Выборка.Следующий();
		Для Каждого Поле Из РезультатЗапроса.Колонки Цикл
			Результат.Вставить(Поле.Имя, Выборка[Поле.Имя]);
		КонецЦикла;
	КонецЕсли;
	Возврат Результат;

КонецФункции

// Записывает данные сеанса OAuth в регистр сведений НастройкиСинхронизацииGoogle
//
// Параметры:
//  Узел - ПланОбменаСсылка.СинхронизацияКалендарей
//  Данные - Структура - сеансовые данные,
//  ключи соответствуют ресурсам регистра НастройкиСинхронизацииGoogle
//
Процедура ЗаписатьДанныеАвторизации(Узел, Данные) Экспорт

	Если Не ЗначениеЗаполнено(Данные.ТокенДоступа) Тогда
		Возврат;
	КонецЕсли;
	УстановитьПривилегированныйРежим(Истина);
	МенеджерЗаписи = СоздатьМенеджерЗаписи();
	ЗаполнитьЗначенияСвойств(МенеджерЗаписи, Данные);
	МенеджерЗаписи.Узел = Узел;
	МенеджерЗаписи.Записать();

КонецПроцедуры	

// Удаляет сеансовые данные в регистре сведений НастройкиСинхронизацииGoogle
//
Процедура УдалитьДанныеАвторизации(Узел) Экспорт

	УстановитьПривилегированныйРежим(Истина);
	МенеджерЗаписи = СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Узел = Узел;
	МенеджерЗаписи.Прочитать();
	Если МенеджерЗаписи.Выбран() Тогда
		МенеджерЗаписи.Удалить();
	КонецЕсли;

КонецПроцедуры

// Выполняет чтение сеансовых данных из регистра и,
// в случае необходимости, обновление данных из Google
//
// Параметры:
//  Узел - ПланОбменаСсылка.СинхронизацияКалендарей
//
Функция ДействительныеДанныеАвторизации(Узел) Экспорт

	УстановитьПривилегированныйРежим(Истина);
	Данные = ДанныеАвторизации(Узел);
	Если ТокенДоступаДействителен(Данные.ТокенДоступа) Тогда
		Возврат Данные;
	КонецЕсли;
	ОбновитьДанныеАвторизации(Узел, Данные);
	Возврат Данные;

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Проверяет токен доступа на сервере Google
//
// Параметры:
//  ТокенДоступа - Строка - токен доступа, полученный в процессе авторизации OAuth2
// 
// Возвращаемое значение:
//  Булево - признак действетельности Токена доступа
//
Функция ТокенДоступаДействителен(ТокенДоступа)

	Если Не ЗначениеЗаполнено(ТокенДоступа) Тогда
		Возврат Ложь;
	КонецЕсли;
	АдресДляПолученияТокенаДоступа = ОбщегоНазначенияКлиентСервер.СтруктураURI(
	"https://www.googleapis.com/oauth2/v1/tokeninfo");
	ИнтернетПрокси = ПолучениеФайловИзИнтернетаКлиентСервер.ПолучитьПрокси(АдресДляПолученияТокенаДоступа.Схема);
	HTTPСоединение = Новый HTTPСоединение(
		АдресДляПолученияТокенаДоступа.Хост,
		АдресДляПолученияТокенаДоступа.Порт,,,
		ИнтернетПрокси,
		120,
		ОбщегоНазначенияКлиентСервер.НовоеЗащищенноеСоединение());
	ЗапросHTTP = Новый HTTPЗапрос;
	ЗапросHTTP.АдресРесурса = АдресДляПолученияТокенаДоступа.ПутьНаСервере;
	ЗапросHTTP.Заголовки["Content-Type"] = "application/x-www-form-urlencoded";
	ЗапросHTTP.УстановитьТелоИзСтроки(
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("access_token=%1", ТокенДоступа));
	Попытка
		ОтветHTTP = HTTPСоединение.ОтправитьДляОбработки(ЗапросHTTP);
	Исключение
		ИмяСобытия = НСтр("ru = 'Синхронизация календарей.Google'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка());
		ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка,,, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		ВызватьИсключение;
	КонецПопытки;
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(ОтветHTTP.ПолучитьТелоКакСтроку());
	РезультатЧтенияJSON = ПрочитатьJSON(ЧтениеJSON);
	Если РезультатЧтенияJSON.Свойство("expires_in") И РезультатЧтенияJSON.expires_in < 300 Тогда
		// Если токену доступа осталось жить меньше пяти минут, принудительно обновляем
		Возврат Ложь;
	КонецЕсли;
	Если Не РезультатЧтенияJSON.Свойство("issued_to") Тогда
		Возврат Ложь;
	КонецЕсли;
	// Ключевая проверка: идентификаторы для действительного токена должны совпадать
	Возврат РезультатЧтенияJSON.issued_to = СинхронизацияGoogle.ИдентификаторПриложения().client_id;

КонецФункции

// Обновляет токен доступа в Google с использованем токена обновления
// и записывает полученные данные в регистр сведений НастройкиСинхронизацииGoogle
//
// Параметры:
//  Узел - ПланОбменаСсылка.СинхронизацияКалендарей
//  Данные - Структура - структура, содержащая токен для обновления в поле "ТокенОбновления"
//
Процедура ОбновитьДанныеАвторизации(Узел, Данные)

	Если Не Данные.Свойство("ТокенОбновления") Тогда
		Возврат;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(Данные.ТокенОбновления) Тогда
		Возврат;
	КонецЕсли;
	ИдентификаторПриложения = СинхронизацияGoogle.ИдентификаторПриложения();
	АдресДляПолученияТокенаДоступа = ОбщегоНазначенияКлиентСервер.СтруктураURI(
		ИдентификаторПриложения.token_uri);
	ИнтернетПрокси = ПолучениеФайловИзИнтернетаКлиентСервер.ПолучитьПрокси(АдресДляПолученияТокенаДоступа.Схема);
	HTTPСоединение = Новый HTTPСоединение(
		АдресДляПолученияТокенаДоступа.Хост,
		АдресДляПолученияТокенаДоступа.Порт,,,
		ИнтернетПрокси,
		120,
		ОбщегоНазначенияКлиентСервер.НовоеЗащищенноеСоединение());
	ЗапросHTTP = Новый HTTPЗапрос;
		ЗапросHTTP.АдресРесурса = АдресДляПолученияТокенаДоступа.ПутьНаСервере;
		ЗапросHTTP.Заголовки["Content-Type"] = "application/x-www-form-urlencoded";
		ЗапросHTTP.УстановитьТелоИзСтроки(
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		"grant_type=refresh_token&client_id=%1&client_secret=%2&refresh_token=%3",
		ИдентификаторПриложения.client_id,
		ИдентификаторПриложения.client_secret,
		Данные.ТокенОбновления));
	Попытка
		ОтветHTTP = HTTPСоединение.ОтправитьДляОбработки(ЗапросHTTP);
	Исключение
		ИмяСобытия = НСтр("ru = 'Синхронизация календарей.Google'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка());
		ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка,,,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		ВызватьИсключение;
	КонецПопытки;
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(ОтветHTTP.ПолучитьТелоКакСтроку());
	РезультатЧтенияJSON = ПрочитатьJSON(ЧтениеJSON);
	Если РезультатЧтенияJSON.Свойство("access_token") Тогда
		Данные.Вставить("ТокенДоступа", РезультатЧтенияJSON.access_token);
	Иначе
		ИмяСобытия = НСтр("ru = 'Синхронизация календарей.Google'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка());
		ОписаниеОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Не удалось получить токен доступа для узла %1.'"), Строка(Узел));
		ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка,,, ОписаниеОшибки);
		ВызватьИсключение НСтр("ru = 'Не удалось получить токен доступа. Возможно приложению запрещен доступ к аккаунту Google или был передан неверный токен обновления.'");
	КонецЕсли;
	Если РезультатЧтенияJSON.Свойство("refresh_token") Тогда
		Данные.Вставить("ТокенОбновления", РезультатЧтенияJSON.refresh_token);
	КонецЕсли;
	Если РезультатЧтенияJSON.Свойство("token_type") Тогда
		Данные.Вставить("ТипТокенаДоступа", РезультатЧтенияJSON.token_type);
	КонецЕсли;
	ЗаписатьДанныеАвторизации(Узел, Данные);

КонецПроцедуры

#КонецОбласти

#КонецЕсли
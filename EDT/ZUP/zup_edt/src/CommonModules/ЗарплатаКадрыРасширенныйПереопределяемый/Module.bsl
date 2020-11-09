
#Область ПрограммныйИнтерфейс

// Позволяет отключить ввод данных о выполненных работах документом ввода данных для расчета зарплаты.
// Предназначен для случаев, когда регистрация выполненных сдельно работ осуществляется специализированными документами,
// и универсальный инструмент ввода не требуется.
//
// Параметры:
//  ДоступностьРегистрации - булево, по умолчанию Истина.
//
Процедура ОпределитьДоступностьРегистрацииВыполненныхРаботДокументомВводаДанныхДляРасчетаЗарплаты(ДоступностьРегистрации) Экспорт
	
КонецПроцедуры

// Предназначена для управления доступностью единого флажка включения/отключения библиотеки «Зарплата и кадры» в целом.
//
// Параметры: 
//	ДоступностьУстановки - булево, по умолчанию Ложь.
//
Процедура ОпределитьДоступностьУстановкиИспользованияЗарплатаКадры(ДоступностьУстановки) Экспорт
	
КонецПроцедуры

// Предназначена для определения необходимости использования штатного расписания по умолчанию.
//
// Параметры: 
//	ШтатноеРасписаниеВсегдаИспользуется - тип булево.
//
Процедура ОпределитьОбязательностьИспользованияШтатногоРасписания(ШтатноеРасписаниеВсегдаИспользуется) Экспорт
	
КонецПроцедуры

// Обработчик события, возникающего при включении/отключении библиотеки «Зарплата и кадры» в целом.
//
// Параметры:
//	Использование - булево, устанавливаемое значение использования.
//
Процедура ПриУстановкеИспользованияЗарплатаКадры(Использование) Экспорт
	
КонецПроцедуры

// Заполняет сведения об ответственных лицах
// Параметры:
//		СписокФизическихЛиц		- Массив, содержит ссылки на физические лица сведения по которым необходимо получить
//		СведенияОбОтветственных	- ТаблицаЗначений
//									* ФизическоеЛицо			- СправочникСсылка.ФизическиеЛица
//									* ПредставлениеДолжности	- Строка
//									* СтруктурнаяЕдиница		- Неопределено
//		СтандартнаяОбработка	- Булево
//
Процедура ЗаполнитьСведенияОбОтветственныхЛицах(СписокФизическихЛиц, СведенияОбОтветственных, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Устанавливает начальное значение константы СтруктураПредприятияНеСоответствуетСтруктуреЮридическихЛиц
// Параметры:
//		Соответствует - Булево, соответствие структуры предприятия и юридической структуры (если Истина, константа устанавливается в Ложь).
//
Процедура ПриУстановкеСоответствияСтруктурыПредприятияСтруктуреЮридическихЛиц(Соответствует) Экспорт 
	
КонецПроцедуры

// Предназначена для определения необходимости использования структуры предприятия для отражения в учете.
//
// Параметры: 
//	Использование - тип булево.
//
Процедура ОпределитьИспользованиеСтруктурыПредприятияДляОтраженияВРегламентированномУчете(Использование) Экспорт
	
КонецПроцедуры

// Переопределяет данные клиентского приложения, используемые для авторизации в Google
// Подробнее см. ЗарплатаКадрыРасширенный.ИдентификацияПриложенияДляGoogle().
//
// Параметры:
//	ИдентификаторПриложения - Структура 
//								*client_id		- Строка
//								*client_secret	- Строка
//
Процедура ПриОпределенииИдентификацииПриложенияДляGoogle(ИдентификаторПриложения) Экспорт
	
КонецПроцедуры

// Переопределяет данные клиентского приложения, используемые для авторизации на сайте hh.ru
// Подробнее см. ЗарплатаКадрыРасширенный.ИдентификацияПриложенияДляHeadHunter().
//
// Параметры:
//	ИдентификаторПриложения - Структура - содержит:
//		*client_id		- Строка
//		*client_secret	- Строка
//		*redirect_uri	- Строка
//
Процедура ПриОпределенииИдентификацииПриложенияДляHeadHunter(ИдентификаторПриложения) Экспорт
	
КонецПроцедуры

// Переопределяет данные клиентского приложения, используемые для авторизации на сайте zarplata.ru
// Подробнее см. ЗарплатаКадрыРасширенный.ИдентификацияПриложенияДляZarplata().
//
// Параметры:
//	ИдентификаторПриложения - Структура - содержит:
//		*client_id		- Строка
//		*client_secret	- Строка
//		*redirect_uri	- Строка
//
Процедура ПриОпределенииИдентификацииПриложенияДляZarplata(ИдентификаторПриложения) Экспорт
	
КонецПроцедуры

#КонецОбласти
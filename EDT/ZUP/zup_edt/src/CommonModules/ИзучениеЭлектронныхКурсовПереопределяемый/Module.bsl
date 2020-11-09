#Область ПрограммныйИнтерфейс

// Вызывается после окончания изучения электронного курса учащимся.
//
// Параметры:
//   ЭлектронныйКурс - СправочникСсылка.ЭлектронныеКурсы - Ссылка на электронный курс.
//   Контекст - ОпределяемыйТип.КонтекстЭлектронногоОбучения - 
//              Задает ссылку на событие, в рамках которого пользователь изучает курс.
//   Учащийся - ОпределяемыйТип.УчащийсяЭлектронногоОбучения - 
//              Задает ссылку на учащегося.
//   Данные - Структура - Значения структуры:
//             - Балл - Число - оценка в стобалльной шкале.
//             
//
Процедура ПослеИзученияЭлектронногоКурса(ЭлектронныйКурс, Контекст, Учащийся, Данные) Экспорт
	
	ЗарплатаКадрыРасширенный.ПослеИзученияЭлектронногоКурса(ЭлектронныйКурс, Контекст, Учащийся, Данные);
	
КонецПроцедуры

// Вызывается при создании формы электронного курса и перед выполнением проверок.
// Можно отказаться от открытия или переопределить переменные.
// 
// Параметры:
//   ЭлектронныйКурс - СправочникСсылка.ЭлектронныеКурсы - Ссылка на электронный тест.
//   Контекст - ОпределяемыйТип.КонтекстЭлектронногоОбучения - 
//              Задает ссылку на событие, в рамках которого проходит тестирование.
//   Учащийся - ОпределяемыйТип.УчащийсяЭлектронногоОбучения - 
//                 Задает ссылку на тестируемого.
//   РежимПроверки - Булево - Форма открыта для проверки преподавателем.
//   РежимРедактирования - Булево - Форма открыта для редактирования курса.
//   РежимПросмотра - Булево - Форма открыта для изучения курса.
//   ИмяОповещенияПриЗакрытии - Строка - Имя оповещения, которое будет вызвано после закрытия.
//   Отказ - Булево - Отказ от открытия.
// 
Процедура ПриСозданииФормыЭлектронногоКурса(ЭлектронныйКурс, Контекст, Учащийся, РежимПроверки, РежимРедактирования, РежимПросмотра, ИмяОповещенияПриЗакрытии, Отказ) Экспорт
		
	ЗарплатаКадрыРасширенный.ПриСозданииФормыЭлектронногоКурса(ЭлектронныйКурс, Контекст, Учащийся, РежимПроверки, РежимРедактирования, РежимПросмотра, ИмяОповещенияПриЗакрытии, Отказ);
	
КонецПроцедуры

// Вызывается при начале изучения курса.
// Может быть использована для регистрации события.
// Отказаться от изучения нельзя.
// Для одного изучения может вызываться несколько раз.
//
// Параметры:
//   ЭлектронныйКурс - СправочникСсылка.ЭлектронныеКурсы - Ссылка на электронный курс.
//   Контекст - ОпределяемыйТип.КонтекстЭлектронногоОбучения - 
//              Задает ссылку на событие, в рамках которого проходит изучение курса.
//   Учащийся - ОпределяемыйТип.УчащийсяЭлектронногоОбучения - 
//              Задает ссылку на тестируемого.
//
Процедура ПриИзученииЭлектронногоКурса(ЭлектронныйКурс, Контекст, Учащийся) Экспорт
	
КонецПроцедуры

// Вызывается при закрытии электронного курса.
// Отказаться от закрытия нельзя.
//
// Параметры:
//   ЭлектронныйКурс - СправочникСсылка.ЭлектронныеКурсы - Ссылка на электронный курс.
//   Контекст - ОпределяемыйТип.КонтекстЭлектронногоОбучения - 
//              Задает ссылку на событие, в рамках которого пользователь изучает курс.
//   Учащийся - ОпределяемыйТип.УчащийсяЭлектронногоОбучения - 
//              Задает ссылку на учащегося.
//   Данные - Структура - Значения структуры:
//             - ЗавершеноВПроцентах - Число - прогресс изучения.
//             
//
Процедура ПриЗакрытииФормыЭлектронногоКурса(ЭлектронныйКурс, Контекст, Учащийся, Данные) Экспорт	
		
	ЗарплатаКадрыРасширенный.ПриЗакрытииФормыЭлектронногоКурса(ЭлектронныйКурс, Контекст, Учащийся, Данные);
	
КонецПроцедуры

// Обработчик вызывается после загрузки курса через XML.
//
Процедура ПослеЗагрузкиЭлектронногоКурсаВБазу() Экспорт
	
КонецПроцедуры

// Вызывается при открытии формы списка электронных курсов.
//
// Параметры:
//   ТипыЭлектронныхКурсов - ПеречислениеСсылка.ТипыЭлектронныхКурсов - доступные типы курсов.
//   СтандартнаяОбработка - Булево - при значении Истина можно определить свой набор типов курсов.
//
Процедура ПриОпределенииВариантаИнтерфейса(ТипыЭлектронныхКурсов, СтандартнаяОбработка) Экспорт
		
КонецПроцедуры

// Определяет версию обработчика обновления подсистемы электронного обучения
// при внедрении ее в родительскую подсистему.
// Список версий см. ОбновлениеИнформационнойБазыБЭО.ПриДобавленииОбработчиковОбновления.
//
// Параметры:
//   СоответствиеВерсий - Соответствие - соответствие версии подсистемы Электронное обучение
//                        и родительской подсистемы.
//
//
Процедура ПриОпределенииСоответствияВерсийОбработчиковОбновлений(СоответствиеВерсий) Экспорт
	
	ЗарплатаКадрыРасширенный.ПриОпределенииСоответствияВерсийОбработчиковОбновлений(СоответствиеВерсий);
	
КонецПроцедуры

#КонецОбласти

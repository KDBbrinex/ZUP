#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	ЗарплатаКадры.ПроверитьКорректностьДаты(Ссылка, НачалоПериода, "Объект.НачалоПериода", Отказ, НСтр("ru='Начало периода аттестации'"), , , Ложь);
	
	Если АттестацииСотрудников.ТипАттестации(ВидАттестации) = Перечисления.ТипыАттестацииСотрудников.ПодтверждениеСоответствияДолжности Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "Сотрудники.Специальность");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "Сотрудники.Категория");
	Иначе
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "Сотрудники.Должность");
	КонецЕсли;
	
	Если АттестацииСотрудников.ЭтоВнешняяАттестация(ВидАттестации) Тогда
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "СоставАттестационнойКомиссии");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "СоставАттестационнойКомиссии.ЧленКомиссии");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "СоставАттестационнойКомиссии.РольВКомиссии");
		ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "ПриказОФормированииКомиссии");
	Иначе 
		Если АттестацииСотрудников.ГрафикАттестацииИКомиссияУтверждаютсяОднимДокументом() Тогда
			ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "ПриказОФормированииКомиссии");
		Иначе 
			ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "СоставАттестационнойКомиссии");
			ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "СоставАттестационнойКомиссии.ЧленКомиссии");
			ОбщегоНазначенияКлиентСервер.УдалитьЗначениеИзМассива(ПроверяемыеРеквизиты, "СоставАттестационнойКомиссии.РольВКомиссии");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли
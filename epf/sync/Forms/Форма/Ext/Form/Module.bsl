﻿//1. отключить выполнение фоновых заданий
//2. поменять константы
//3. Очистить реквизиты в справочниках
//4. Комментировать выполнение кода

//Возм действия
//- удаление
//- очистка рекизитов
//- комментирование текста
//- замена содержимого

#Область ОписаниеПеременных

#КонецОбласти

#Область ОбработчикиСобытийФормы
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Элементы.РежимОбработки.СписокВыбора.ЗагрузитьЗначения(ВозможныеРежимыОбработки());
	РежимОбработки = ПодготовкаДанных();
	
	ЗаполнитьЗначенияСвойств(ЭтаФорма, ПараметрыСервисаПоУмолчанию());
	РежимОбработкиПриИзменении(Неопределено);
	ИнициализацияНастроекНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура РежимОбработкиПриИзменении(Элемент)
	
	Если РежимОбработки = ПодготовкаДанных() Тогда
		ИнициализироватьРежимПодготовкиДанных();
	ИначеЕсли РежимОбработки = ОчисткаБазы() Тогда
		ИнициализироватьРежимОчисткиБазы();
	Иначе
		ВызватьИсключение "ru='Установлен неизвестный режим обработки'";
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыМетаданныеКонфигурации

&НаКлиенте
Процедура МетаданныеКонфигурацииВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если ПустаяСтрока(Элемент.ТекущиеДанные.ПолноеИмя) Тогда
		Возврат;
	КонецЕсли;
	
	Элементы.ГруппаКонфигурация.Видимость = Ложь;
	Элементы.ГруппаНастройка.Видимость = Истина;
	
	ИзменяемыеДанные.Очистить();
	
	Если СтрНайти(НРег(Элемент.ТекущиеДанные.ПолноеИмя), "константа")>0 Тогда
		нс = ИзменяемыеДанные.Добавить();
		нс.ТекущееЗначение = ЗначениеКонстанты(Элемент.ТекущиеДанные.Имя);
	КонецЕсли;
	
	Элементы.ДекорацияРедактируемыйТип.Заголовок = Элемент.ТекущиеДанные.ПолноеИмя;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыИзменяемыеДанные

&НаКлиенте
Процедура ИзменяемыеДанныеПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	
	Если Копирование Тогда
		Возврат;
	КонецЕсли;
	мас = Новый Массив;
	мас.Добавить("Справочник.Файлы");
	Элемент.ПодчиненныеЭлементы.ИзменяемыеДанныеТекущееЗначение.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.Файлы");
	//Если СтрНайти(НРег(Элементы.ДекорацияРедактируемыйТип.Заголовок), "справочник")>0 Тогда 
	//	
	//	Элемент.Тип = Элементы.ДекорацияРедактируемыйТип.Заголовок;
	//	
	//КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменяемыеДанныеПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	// Вставить содержимое обработчика.
КонецПроцедуры

&НаКлиенте
Процедура ИзменяемыеДанныеОперацияПриИзменении(Элемент)
	
	Если Элемент.ТекстРедактирования = Удаление() Тогда
		Элементы.ИзменяемыеДанные.ПодчиненныеЭлементы.ИзменяемыеДанныеЗначение.ТолькоПросмотр = Истина;
	ИначеЕсли Элемент.ТекстРедактирования = ОчисткаРеквизитов() Тогда

	ИначеЕсли Элемент.ТекстРедактирования = КомментированиеТекста() Тогда

	//ИначеЕсли Элемент.ТекстРедактирования = ЗаменаСодержимого() Тогда
	//	Сообщить("вввв");
	Иначе
		ВызватьИсключение "неизвестная команда";
	КонецЕсли;
	
КонецПроцедуры
#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура НастройкаГотова(Команда)
	
	Элементы.ГруппаКонфигурация.Видимость = Истина;
	Элементы.ГруппаНастройка.Видимость = Ложь;
	
	Для Каждого стрНастройки из ИзменяемыеДанные Цикл
		
		ДобавитьЗаписьКОбщемуСписку(Элементы.ДекорацияРедактируемыйТип.Заголовок,
							стрНастройки.ТекущееЗначение,
							стрНастройки.Операция,
							стрНастройки.НовоеЗначение);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ВернутьсяКДеревуМетаданных(Команда)
	
	Элементы.ГруппаКонфигурация.Видимость = Истина;
	Элементы.ГруппаНастройка.Видимость = Ложь;

КонецПроцедуры

&НаКлиенте
Процедура ПолучитьНастройки(Команда)
	
	Запрос = Новый HTTPЗапрос;
	Запрос.АдресРесурса = АдресAPIv1();
	
	Ответ = НовоеHTTPСоединение().Получить(Запрос);
	Действия = Ответ.ПолучитьТелоКакСтроку();
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправитьНовыеНастройки(Команда)
		
	Запрос = Новый HTTPЗапрос;
	Запрос.АдресРесурса = "api/v1/upld/";
	Запрос.Заголовки.Вставить("base", "bigsoft");
	Запрос.Заголовки.Вставить("Content-Type", "application/json");
	Запрос.УстановитьТелоИзСтроки(ЖЫСОН(), КодировкаТекста.UTF8, ИспользованиеByteOrderMark.НеИспользовать);
	
	Ответ = НовоеHTTPСоединение().ОтправитьДляОбработки(Запрос);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ЗначениеКонстанты(Имя)
	
	Возврат Константы[Имя].Получить();
	
КонецФункции

&НаКлиенте
Функция ДобавитьЗаписьКОбщемуСписку(ТипДанных, СтароеЗначение, Операция, НовоеЗначение)
	
	НоваяЗапись = ВсеДанные.Добавить();
	НоваяЗапись.ТипИмя = ТипДанных;
	НоваяЗапись.Действие = Операция;
	НоваяЗапись.Ссылка = СтароеЗначение;  
	НоваяЗапись.НовоеЗначение = НовоеЗначение;
	
КонецФункции

#Область ИНИЦИАЛИЗАЦИИ_ПАРАМЕТРОВ

&НаКлиентеНаСервереБезКонтекста
Функция ПараметрыСервисаПоУмолчанию()
	
	параметры = Новый Структура;
	параметры.Вставить("подключениеАдресСервера", "localhost");
	параметры.Вставить("подключениеНомерПорта", 8000);
	параметры.Вставить("подключениеПользователь", "");
	параметры.Вставить("подключениеПароль", "");
	Возврат параметры;
	
КонецФункции

&НаСервере
Процедура ИнициализацияНастроекНаСервере()
	
	ДеревоМетаданныхКонфигурации(МетаданныеКонфигурации);
	
КонецПроцедуры

&НаКлиенте
Процедура ИнициализироватьРежимПодготовкиДанных()
	
	ЭлементыРежима = Новый Соответствие;
	ЭлементыРежима.Вставить("ГруппаОчисткаБазы", Ложь);
	ЭлементыРежима.Вставить("ГруппаПодготовкаДанных", Истина);
	ЭлементыРежима.Вставить("ГруппаКонфигурация", Истина);
	ЭлементыРежима.Вставить("ГруппаНастройка", Ложь);
	ЭлементыРежима.Вставить("ФормаПолучитьНастройки", Ложь);
	
	ИнициализироватьВидимостьЭлементовПоКоллекции(ЭлементыРежима);
	
	Элементы.ИзменяемыеДанныеОперация.СписокВыбора.ЗагрузитьЗначения(ВариантыДействийНадДанными());
	
КонецПроцедуры

&НаКлиенте
Процедура ИнициализироватьРежимОчисткиБазы()
	
	ЭлементыРежима = Новый Соответствие;
	ЭлементыРежима.Вставить("ГруппаОчисткаБазы", Истина);
	ЭлементыРежима.Вставить("ГруппаПодготовкаДанных", Ложь);
	ЭлементыРежима.Вставить("ФормаПолучитьНастройки", Истина);
	ЭлементыРежима.Вставить("ФормаОтправитьНовыеНастройки", Ложь);
	
	ИнициализироватьВидимостьЭлементовПоКоллекции(ЭлементыРежима);
	
КонецПроцедуры
#КонецОбласти

#Область СЕТЕВЫЕ_ВЫЗОВЫ

Функция НовоеHTTPСоединение()
	
	Соединение = Новый HTTPСоединение(подключениеАдресСервера, 
								подключениеНомерПорта, 
								подключениеПользователь, 
								подключениеПароль);
	Возврат Соединение;
	
КонецФункции
#КонецОбласти

// Получает дерево метаданных конфигурации с заданным отбором по объектам метаданных.
//
// Параметры:
//   Отбор - Структура - содержит значения элементов отбора.
//						Если параметр задан, то будет получено дерево метаданных в соответствии с заданным отбором:
//						Ключ - Строка - имя свойства элемента метаданных;
//						Значение - Массив - множество значений для отбора.
//
// Пример инициализации переменной "Отбор":
//
// Массив = Новый Массив;
// Массив.Добавить("Константа.ИспользоватьСинхронизациюДанных");
// Массив.Добавить("Справочник.Валюты");
// Массив.Добавить("Справочник.Организации");
// Отбор = Новый Структура;
// Отбор.Вставить("ПолноеИмя", Массив);
// 
// Возвращаемое значение:
//   ДеревоЗначений - дерево описания метаданных конфигурации.
//
Процедура ДеревоМетаданныхКонфигурации(ДеревоМетаданных) Экспорт
	Отбор = Неопределено;
	ИспользоватьОтбор = (Отбор <> Неопределено);
	
	КоллекцииОбъектовМетаданных = Новый ТаблицаЗначений;
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Имя");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Синоним");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("Картинка");
	КоллекцииОбъектовМетаданных.Колонки.Добавить("КартинкаОбъекта");
	
	НоваяСтрокаКоллекцииОбъектовМетаданных("Константы",               НСтр("ru = 'Константы'"),                 БиблиотекаКартинок.Константа,              БиблиотекаКартинок.Константа,                    КоллекцииОбъектовМетаданных);
	НоваяСтрокаКоллекцииОбъектовМетаданных("Справочники",             НСтр("ru = 'Справочники'"),               БиблиотекаКартинок.Справочник,             БиблиотекаКартинок.Справочник,                   КоллекцииОбъектовМетаданных);
	НоваяСтрокаКоллекцииОбъектовМетаданных("Документы",               НСтр("ru = 'Документы'"),                 БиблиотекаКартинок.Документ,               БиблиотекаКартинок.ДокументОбъект,               КоллекцииОбъектовМетаданных);
	НоваяСтрокаКоллекцииОбъектовМетаданных("ПланыВидовХарактеристик", НСтр("ru = 'Планы видов характеристик'"), БиблиотекаКартинок.ПланВидовХарактеристик, БиблиотекаКартинок.ПланВидовХарактеристикОбъект, КоллекцииОбъектовМетаданных);
	НоваяСтрокаКоллекцииОбъектовМетаданных("ПланыСчетов",             НСтр("ru = 'Планы счетов'"),              БиблиотекаКартинок.ПланСчетов,             БиблиотекаКартинок.ПланСчетовОбъект,             КоллекцииОбъектовМетаданных);
	НоваяСтрокаКоллекцииОбъектовМетаданных("ПланыВидовРасчета",       НСтр("ru = 'Планы видов расчета'"),       БиблиотекаКартинок.ПланВидовРасчета,       БиблиотекаКартинок.ПланВидовРасчетаОбъект,       КоллекцииОбъектовМетаданных);
	НоваяСтрокаКоллекцииОбъектовМетаданных("РегистрыСведений",        НСтр("ru = 'Регистры сведений'"),         БиблиотекаКартинок.РегистрСведений,        БиблиотекаКартинок.РегистрСведений,              КоллекцииОбъектовМетаданных);
	НоваяСтрокаКоллекцииОбъектовМетаданных("РегистрыНакопления",      НСтр("ru = 'Регистры накопления'"),       БиблиотекаКартинок.РегистрНакопления,      БиблиотекаКартинок.РегистрНакопления,            КоллекцииОбъектовМетаданных);
	НоваяСтрокаКоллекцииОбъектовМетаданных("РегистрыБухгалтерии",     НСтр("ru = 'Регистры бухгалтерии'"),      БиблиотекаКартинок.РегистрБухгалтерии,     БиблиотекаКартинок.РегистрБухгалтерии,           КоллекцииОбъектовМетаданных);
	НоваяСтрокаКоллекцииОбъектовМетаданных("РегистрыРасчета",         НСтр("ru = 'Регистры расчета'"),          БиблиотекаКартинок.РегистрРасчета,         БиблиотекаКартинок.РегистрРасчета,               КоллекцииОбъектовМетаданных);
	НоваяСтрокаКоллекцииОбъектовМетаданных("БизнесПроцессы",          НСтр("ru = 'Бизнес-процессы'"),           БиблиотекаКартинок.БизнесПроцесс,          БиблиотекаКартинок.БизнесПроцессОбъект,          КоллекцииОбъектовМетаданных);
	НоваяСтрокаКоллекцииОбъектовМетаданных("Задачи",                  НСтр("ru = 'Задачи'"),                    БиблиотекаКартинок.Задача,                 БиблиотекаКартинок.ЗадачаОбъект,                 КоллекцииОбъектовМетаданных);
	
	// Возвращаемое значение функции.
	//ДеревоМетаданных = Новый ДеревоЗначений;
	//ДеревоМетаданных.Колонки.Добавить("Имя");
	//ДеревоМетаданных.Колонки.Добавить("ПолноеИмя");
	//ДеревоМетаданных.Колонки.Добавить("Синоним");
	//ДеревоМетаданных.Колонки.Добавить("Картинка");
	
	Для Каждого СтрокаКоллекции Из КоллекцииОбъектовМетаданных Цикл
		
		СтрокаДерева = ДеревоМетаданных.ПолучитьЭлементы().Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаДерева, СтрокаКоллекции);
		Для Каждого ОбъектМетаданных Из Метаданные[СтрокаКоллекции.Имя] Цикл
			
			Если ИспользоватьОтбор Тогда
				
				ОбъектПрошелФильтр = Истина;
				Для Каждого ЭлементОтбора Из Отбор Цикл
					
					Значение = ?(ВРег(ЭлементОтбора.Ключ) = ВРег("ПолноеИмя"), ОбъектМетаданных.ПолноеИмя(), ОбъектМетаданных[ЭлементОтбора.Ключ]);
					Если ЭлементОтбора.Значение.Найти(Значение) = Неопределено Тогда
						ОбъектПрошелФильтр = Ложь;
						Прервать;
					КонецЕсли;
					
				КонецЦикла;
				
				Если Не ОбъектПрошелФильтр Тогда
					Продолжить;
				КонецЕсли;
				
			КонецЕсли;
			
			СтрокаДереваОМ = СтрокаДерева.ПолучитьЭлементы().Добавить();
			СтрокаДереваОМ.Имя       = ОбъектМетаданных.Имя;
			СтрокаДереваОМ.ПолноеИмя = ОбъектМетаданных.ПолноеИмя();
			СтрокаДереваОМ.Синоним   = ОбъектМетаданных.Синоним;
			СтрокаДереваОМ.Картинка  = СтрокаКоллекции.КартинкаОбъекта;
			
		КонецЦикла;
		
	КонецЦикла;
	
	// Удаляем строки без подчиненных элементов.
	Если ИспользоватьОтбор Тогда
		
		// Используем обратный порядок обхода дерева значений.
		КоличествоЭлементовКоллекции = ДеревоМетаданных.Строки.Количество();
		
		Для ОбратныйИндекс = 1 По КоличествоЭлементовКоллекции Цикл
			
			ТекущийИндекс = КоличествоЭлементовКоллекции - ОбратныйИндекс;
			СтрокаДерева = ДеревоМетаданных.Строки[ТекущийИндекс];
			Если СтрокаДерева.Строки.Количество() = 0 Тогда
				ДеревоМетаданных.Строки.Удалить(ТекущийИндекс);
			КонецЕсли;
			
		КонецЦикла;
	
	КонецЕсли;
	
	//Возврат ДеревоМетаданных;
	
КонецПроцедуры

Процедура НоваяСтрокаКоллекцииОбъектовМетаданных(Имя, Синоним, Картинка, КартинкаОбъекта, Коллекция)
	
	нс = Коллекция.Добавить();
	нс.Имя = Имя;
	нс.Синоним = Синоним;
	нс.Картинка = Картинка;
	нс.КартинкаОбъекта = КартинкаОбъекта;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ВариантыДействийНадДанными()
	
	всеДействия = Новый Массив;
	всеДействия.Добавить(Удаление());
	всеДействия.Добавить(ОчисткаРеквизитов());
	всеДействия.Добавить(КомментированиеТекста());
	всеДействия.Добавить(ЗаменаСодержимого());
	
	Возврат всеДействия;
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ВозможныеРежимыОбработки()
	
	Режимы = Новый Массив;
	Режимы.Добавить(ОчисткаБазы());
	Режимы.Добавить(ПодготовкаДанных());
	
	Возврат Режимы;
	
КонецФункции

#Область СТРОКОВЫЕ_КОНСТАНТЫ
&НаКлиентеНаСервереБезКонтекста
Функция ОчисткаБазы()
	
	Возврат "Очистка базы";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ПодготовкаДанных()

	Возврат "Подготовка данных";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция Удаление()
	
	Возврат "Удаление";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ОчисткаРеквизитов()
	
	Возврат "Очистка реквизитов";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция КомментированиеТекста()
	
	Возврат "Комментирование текста";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ЗаменаСодержимого()
	
	Возврат "Замена содержимого";
	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция АдресAPIv1()
	
	Возврат "api/v1/devset/bigsoft";
	
КонецФункции
#КонецОбласти

&НаКлиенте
Процедура ИнициализироватьВидимостьЭлементовПоКоллекции(ЭлементыРежима)
	
	Для каждого тЭлемент из ЭлементыРежима Цикл
		Элементы[тЭлемент.Ключ].Видимость = тЭлемент.Значение;
	КонецЦикла;
	
КонецПроцедуры
#КонецОбласти

&НаКлиенте
Функция ЖЫСОН()
возврат "{
    |""config"": {
    |    ""title"": ""example glossary"",
	|	""GlossDiv"": {
    |        ""title"": ""S"",
|			""GlossList"": {
  |              ""GlossEntry"": {
   |                 ""ID"": ""SGML"",
	|				""SortAs"": ""SGML"",
	|				""GlossTerm"": ""Standard Generalized Markup Language"",
	|				""Acronym"": ""SGML"",
	|				""Abbrev"": ""ISO 8879:1986"",
	|				""GlossDef"": {
     |                   ""para"": ""A meta-markup language, used to create markup languages such as DocBook."",
	|					""GlossSeeAlso"": [""GML"", ""XML""]
    |                },
|					""GlossSee"": ""markup""
    |            }
    |        }
    |    }
    |}
|}	";
КонецФункции
///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////




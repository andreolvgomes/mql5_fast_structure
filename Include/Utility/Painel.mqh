//+------------------------------------------------------------------+
//|                                                       Painel.mqh |
//|                        Copyright 2019, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#define EXPERT_NAME MQL5InfoString(MQL5_PROGRAM_NAME) // Name of the Expert Advisor
#include  <Trade\Trade.mqh>

#include <Object.mqh>
//--
class Painel:public CObject
  {
private:

public:
                     Painel(void) {};
                    ~Painel(void) {};
   void              CriaPainel();
   void              RefreshTrade(ENUM_POSITION_TYPE position_type,double takeprofit, double takepoint,double volume);
   void              MetaBatida(bool max_profit,bool max_loss, bool max_inputs);
   void              HistoryProfit(int numerotrades,double dayHistProfit,double weekHistProfit,double monthHistProfit);
   void              DeletePanel();
  };
//--
void Painel::HistoryProfit(int numerotrades,double dayHistProfit,double weekHistProfit,double monthHistProfit)
  {
   ObjectSetString(0,"NumeroTrades",OBJPROP_TEXT,numerotrades);

   ObjectSetString(0,"ResultDia",OBJPROP_TEXT,DecimalStr(dayHistProfit));
   ObjectSetInteger(0,"ResultDia",OBJPROP_COLOR,clrWhite);
   if(dayHistProfit<0)
      ObjectSetInteger(0,"ResultDia",OBJPROP_COLOR,clrRed);
   else
      if(dayHistProfit>0)
         ObjectSetInteger(0,"ResultDia",OBJPROP_COLOR,clrGreen);

   ObjectSetString(0,"ResultSemana",OBJPROP_TEXT,DecimalStr(weekHistProfit));
   ObjectSetInteger(0,"ResultSemana",OBJPROP_COLOR,clrWhite);
   if(weekHistProfit<0)
      ObjectSetInteger(0,"ResultSemana",OBJPROP_COLOR,clrRed);
   else
      if(weekHistProfit>0)
         ObjectSetInteger(0,"ResultSemana",OBJPROP_COLOR,clrGreen);

   ObjectSetString(0,"ResultMes",OBJPROP_TEXT,DecimalStr(monthHistProfit));
   ObjectSetInteger(0,"ResultMes",OBJPROP_COLOR,clrWhite);
   if(monthHistProfit<0)
      ObjectSetInteger(0,"ResultMes",OBJPROP_COLOR,clrRed);
   else
      if(monthHistProfit>0)
         ObjectSetInteger(0,"ResultMes",OBJPROP_COLOR,clrGreen);
  }
//--
void Painel::MetaBatida(bool max_profit,bool max_loss, bool max_inputs)
  {
   ObjectSetString(0,"Limite",OBJPROP_TEXT,"Dia!");
   ObjectSetInteger(0,"Limite",OBJPROP_COLOR,clrGray);
   
   if(max_loss)
     {
      ObjectSetString(0,"Limite",OBJPROP_TEXT,"Perda máxima diaria atingida!");
      ObjectSetInteger(0,"Limite",OBJPROP_COLOR,clrRed);
     }
   if(max_profit)
     {
      ObjectSetString(0,"Limite",OBJPROP_TEXT,"Objetivo de lucro atingido!");
      ObjectSetInteger(0,"Limite",OBJPROP_COLOR,clrGreen);
     }
  }
//--
void Painel::RefreshTrade(ENUM_POSITION_TYPE position_type,double takeprofit, double takepoint,double volume)
  {
   ObjectSetInteger(0,"TradeAberto",OBJPROP_COLOR,clrGray);
   ObjectSetString(0,"Lote",OBJPROP_TEXT,volume);

   ObjectSetString(0,"ResultadoAberto",OBJPROP_TEXT,"0,00");
   ObjectSetInteger(0,"ResultadoAberto",OBJPROP_COLOR,clrWhite);

   ObjectSetString(0,"ResultadoPontos",OBJPROP_TEXT,"0,00");
   ObjectSetInteger(0,"ResultadoPontos",OBJPROP_COLOR,clrWhite);

   ObjectSetString(0,"TradeAberto",OBJPROP_TEXT,"Nenhuma operação aberta");

   if(position_type!=WRONG_VALUE)
     {
      ObjectSetInteger(0,"TradeAberto",OBJPROP_COLOR,clrOrange);

      if(position_type==POSITION_TYPE_BUY)
        {
         ObjectSetString(0,"TradeAberto",OBJPROP_TEXT,"Operando na Compra");
        }
      if(position_type==POSITION_TYPE_SELL)
        {
         ObjectSetString(0,"TradeAberto",OBJPROP_TEXT,"Operando na Venda");
        }

      ObjectSetString(0,"ResultadoAberto",OBJPROP_TEXT,DecimalStr(takeprofit));
      ObjectSetString(0,"ResultadoPontos",OBJPROP_TEXT,DecimalStr(takepoint));
      if(takeprofit>0)
        {
         ObjectSetInteger(0,"ResultadoAberto",OBJPROP_COLOR,clrGreen);
         ObjectSetInteger(0,"ResultadoPontos",OBJPROP_COLOR,clrGreen);
        }
      else
        {
         ObjectSetInteger(0,"ResultadoAberto",OBJPROP_COLOR,clrRed);
         ObjectSetInteger(0,"ResultadoPontos",OBJPROP_COLOR,clrRed);
        }
     }
  }
//--
string DecimalStr(double value)
  {
   string str=DoubleToString(value,2);
   StringReplace(str,".",",");
   return str;
  }
//--
void Painel::CriaPainel()
  {
   SetInfoPanel(10,170);
//SetInfoPanel(6);

   int i=0;
   /*
      ObjectSetString(0,Label(i),OBJPROP_TEXT,"PAINEL DE STATUS");
      ObjectSetInteger(0,"Label_0",OBJPROP_FONTSIZE,15);

      i++;
      ObjectSetString(0,Label(i),OBJPROP_TEXT,"____________________________________");

      i++;
      ObjectSetString(0,Label(i),OBJPROP_TEXT," ");

      i++;
      */
   ObjectSetString(0,Label(i),OBJPROP_TEXT,"Nº de trades no dia:");
   ObjectSetString(0,LabelValue(i),OBJPROP_TEXT,"0");
   ObjectSetString(0,LabelValue(i),OBJPROP_NAME,"NumeroTrades");

   i++;
   ObjectSetString(0,Label(i),OBJPROP_TEXT,"Resultado no dia:");
   ObjectSetString(0,LabelValue(i),OBJPROP_TEXT,"0,00");
   ObjectSetString(0,LabelValue(i),OBJPROP_NAME,"ResultDia");

   i++;
   ObjectSetString(0,Label(i),OBJPROP_TEXT,"Resultado na semana:");
   ObjectSetString(0,LabelValue(i),OBJPROP_TEXT,"0,00");
   ObjectSetString(0,LabelValue(i),OBJPROP_NAME,"ResultSemana");

   i++;
   ObjectSetString(0,Label(i),OBJPROP_TEXT,"Resultado no mês:");
   ObjectSetString(0,LabelValue(i),OBJPROP_TEXT,"0,00");
   ObjectSetString(0,LabelValue(i),OBJPROP_NAME,"ResultMes");

// i++;
// ObjectSetString(0,Label(i),OBJPROP_TEXT,"____________________________________");

   i++;
   ObjectSetString(0,Label(i),OBJPROP_TEXT," ");

   i++;
   ObjectSetString(0,Label(i),OBJPROP_TEXT,"Nenhuma operação aberta");
   ObjectSetInteger(0,Label(i),OBJPROP_COLOR,clrGray);
   ObjectSetString(0,Label(i),OBJPROP_NAME,"TradeAberto");

// i++;
//ObjectSetString(0,Label(i),OBJPROP_TEXT," ");

   i++;
   ObjectSetString(0,Label(i),OBJPROP_TEXT,"Lote aberto:");
   ObjectSetString(0,LabelValue(i),OBJPROP_TEXT,"0");
   ObjectSetString(0,LabelValue(i),OBJPROP_NAME,"Lote");

   i++;
   ObjectSetString(0,Label(i),OBJPROP_TEXT,"Resultado aberto:");
   ObjectSetString(0,LabelValue(i),OBJPROP_TEXT,"0,00");
   ObjectSetInteger(0,LabelValue(i),OBJPROP_COLOR,clrRed);
   ObjectSetString(0,LabelValue(i),OBJPROP_NAME,"ResultadoAberto");

   i++;
   ObjectSetString(0,Label(i),OBJPROP_TEXT,"Pontos:");
   ObjectSetString(0,LabelValue(i),OBJPROP_TEXT,"0,00");
   ObjectSetInteger(0,LabelValue(i),OBJPROP_COLOR,clrGreen);
   ObjectSetString(0,LabelValue(i),OBJPROP_NAME,"ResultadoPontos");

   i++;
   ObjectSetString(0,Label(i),OBJPROP_TEXT,"Dia!");
   ObjectSetInteger(0,Label(i),OBJPROP_COLOR,clrGray);
   ObjectSetInteger(0,Label(i),OBJPROP_FONTSIZE,12);
   ObjectSetString(0,Label(i),OBJPROP_NAME,"Limite");
  }
//--
string Label(int i)
  {
   return "Label_"+i;
  }
//-
string LabelValue(int i)
  {
   return "LabelValue_"+i;
  }
//| Returning the testing flag                                       |
bool IsTester()
  {
   return(MQL5InfoInteger(MQL5_TESTER));
  }
//| Returning the optimization flag                                  |
bool IsOptimization()
  {
   return(MQL5InfoInteger(MQL5_OPTIMIZATION));
  }
//| Returning the visual testing mode flag                           |
bool IsVisualMode()
  {
   return(MQL5InfoInteger(MQL5_VISUAL_MODE));
  }
//| Returning the flag for real time mode outside the Strategy Tester|
bool IsRealtime()
  {
   if(!IsTester() && !IsOptimization() && !IsVisualMode())
      return(true);
   else
      return(false);
  }
//--
void SetInfoPanel(int quant,double height=250)
  {
//--- Visualization or real time modes
   if(IsVisualMode() || IsRealtime())
     {
      int               y_bg=18;             // Y-coordinate for the background and header
      int               y_property=32;       // Y-coordinate for the list of properties and their values
      int               line_height=15;      // Line height
      //---
      //int               font_size=8;         // Font size
      // string            font_name="Calibri"; // Font
      //color             font_color=clrWhite; // Font color
      //---
      ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER; // Anchor point in the top right corner
      ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER; // Origin of coordinates in the top right corner of the chart

      //--- X-coordinates
      int               x_first_column=10;  // First column (names of properties)
      int               x_second_column=160;  // Second column (values of properties)

      //--- Testing in the visualization mode
      if(MQL5InfoInteger(MQL5_VISUAL_MODE))
        {
         y_bg=2;
         y_property=16;
        }

      //--- Array of Y-coordinates for the names of position properties and their values
      int               y_prop_array[20]= {0};

      //--- Fill the array with coordinates for each line on the info panel
      for(int i=0; i<quant; i++)
        {
         if(i==0)
            y_prop_array[i]=y_property;
         else
            y_prop_array[i]=y_property+line_height*i;
        }

      //--- Background of the info panel
      CreateEdit(0,0,"InfoPanelBackground","",corner,8,clrGray,230,height,5,y_bg,0,C'15,15,15',true);
      //--- Header of the info panel
      //CreateEdit(0,0,"InfoPanelHeader","  POSITION  PROPERTIES",corner,8,clrWhite,230,14,5,y_bg,1,clrFireBrick,true);

      //--- List of the names of position properties and their values
      for(int i=0; i<quant; i++)
        {
         //--- Property name
         CreateLabel(0,0,"Label_"+i,"Label_"+i,x_first_column,y_prop_array[i]);
         //--- Property value
         CreateLabel(0,0,"LabelValue_"+i," ",x_second_column,y_prop_array[i]);
        }
      //---
      ChartRedraw(); // Redraw the chart
      //ObjectDelete(0, "InfoPanelBackground");
     }
  }
//--
void Painel::DeletePanel()
  {
   DeleteObjectByName("InfoPanelBackground");   // Delete the panel background
   DeleteObjectByName("InfoPanelHeader");       // Delete the panel header

   DeleteObjectByName("NumeroTrades");       // Delete the panel header
   DeleteObjectByName("Limite");       // Delete the panel header
   DeleteObjectByName("ResultadoAberto");       // Delete the panel header
   DeleteObjectByName("Lote");       // Delete the panel header
   DeleteObjectByName("ResultMes");       // Delete the panel header
   DeleteObjectByName("ResultSemana");       // Delete the panel header
   DeleteObjectByName("ResultDia");       // Delete the panel header
   DeleteObjectByName("NumeroTrades");       // Delete the panel header
   DeleteObjectByName("TradeAberto");       // Delete the panel header
   DeleteObjectByName("ResultadoPontos");       // Delete the panel header

//--- Delete position properties and their values
   for(int i=0; i<20; i++)
     {
      DeleteObjectByName("Label_"+i);
      DeleteObjectByName("LabelValue_"+i);
     }
//---
   ChartRedraw(); // Redraw the chart
  }
//--
void DeleteObjectByName(string name)
  {
   int  sub_window=0;      // Returns the number of the subwindow where the object is located
   bool res       =false;  // Result following an attempt to delete the object
//--- Find the object by name
   sub_window=ObjectFind(ChartID(),name);
//---
   if(sub_window>=0) // If it has been found,..
     {
      res=ObjectDelete(ChartID(),name); // ...delete it
      //---
      // If an error occurred when deleting the object,..
      if(!res) // ...print the relevant message
        {
         Print("Error deleting the object: ("+IntegerToString(GetLastError())+"): ");
        }
     }
  }
//--
void CreateEdit(long             chart_id,         // chart id
                int              sub_window,       // (sub)window number
                string           name,             // object name
                string           text,             // displayed text
                ENUM_BASE_CORNER corner,           // chart corner
                //string           font_name,        // font
                int              font_size,        // font size
                color            font_color,       // font color
                int              width,// width
                int              height,           // height
                int              x_distance,       // X-coordinate
                int              y_distance,       // Y-coordinate
                long             z_order,          // Z-order
                color            background_color, // background color
                bool             read_only)        // Read Only flag
  {
// If the object has been created successfully,...
   if(ObjectCreate(chart_id,name,OBJ_EDIT,sub_window,0,0))
     {
      // ...set its properties
      ObjectSetString(chart_id,name,OBJPROP_TEXT,text);                 // displayed text
      ObjectSetInteger(chart_id,name,OBJPROP_CORNER,corner);            // set the chart corner
      ObjectSetString(chart_id,name,OBJPROP_FONT,"Calibri");            // set the font
      ObjectSetInteger(chart_id,name,OBJPROP_FONTSIZE,font_size);       // set the font size
      ObjectSetInteger(chart_id,name,OBJPROP_COLOR,font_color);         // font color
      ObjectSetInteger(chart_id,name,OBJPROP_BGCOLOR,background_color); // background color
      ObjectSetInteger(chart_id,name,OBJPROP_XSIZE,width);             // width
      ObjectSetInteger(chart_id,name,OBJPROP_YSIZE,height);             // height
      ObjectSetInteger(chart_id,name,OBJPROP_XDISTANCE,x_distance);     // set the X coordinate
      ObjectSetInteger(chart_id,name,OBJPROP_YDISTANCE,y_distance);     // set the Y coordinate
      ObjectSetInteger(chart_id,name,OBJPROP_SELECTABLE,false);         // cannot select the object if FALSE
      ObjectSetInteger(chart_id,name,OBJPROP_ZORDER,z_order);           // Z-order of the object
      ObjectSetInteger(chart_id,name,OBJPROP_READONLY,read_only);       // Read Only
      ObjectSetInteger(chart_id,name,OBJPROP_ALIGN,ALIGN_LEFT);         // align left
      ObjectSetString(chart_id,name,OBJPROP_TOOLTIP,"\n");              // no tooltip if "\n"
     }
  }
//+------------------------------------------------------------------+
//| CREATING THE LABEL OBJECT                                        |
//+------------------------------------------------------------------+
void CreateLabel(long               chart_id,   // chart id
                 int                sub_window, // (sub)window number
                 string             name,       // object name
                 string             text,       // displayed text
                 // ENUM_ANCHOR_POINT  anchor,     // anchor point
                 //ENUM_BASE_CORNER   corner,     // chart corner
                 //string             font_name,  // font
                 //int                font_size,  // font size
                 //color              font_color, // font color
                 int                x_distance,// X-coordinate
                 int                y_distance // Y-coordinate
                 //long               z_order
                ) // Z-order
  {
// If the object has been created successfully,...
   if(ObjectCreate(chart_id,name,OBJ_LABEL,sub_window,0,0))
     {
      // ...set its properties
      ObjectSetString(chart_id,name,OBJPROP_TEXT,text);              // displayed text
      ObjectSetString(chart_id,name,OBJPROP_FONT,"Calibri");         // set the font
      ObjectSetInteger(chart_id,name,OBJPROP_COLOR,clrWhite);      // set the font color
      ObjectSetInteger(chart_id,name,OBJPROP_ANCHOR,ANCHOR_LEFT_UPPER);         // set the anchor point
      ObjectSetInteger(chart_id,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);         // set the chart corner
      ObjectSetInteger(chart_id,name,OBJPROP_FONTSIZE,10);    // set the font size
      ObjectSetInteger(chart_id,name,OBJPROP_XDISTANCE,x_distance);  // set the X-coordinate
      ObjectSetInteger(chart_id,name,OBJPROP_YDISTANCE,y_distance);  // set the Y-coordinate
      ObjectSetInteger(chart_id,name,OBJPROP_SELECTABLE,false);      // cannot select the object if FALSE
      ObjectSetInteger(chart_id,name,OBJPROP_ZORDER,2);        // Z-order of the object
      ObjectSetString(chart_id,name,OBJPROP_TOOLTIP,"\n");           // no tooltip if "\n"
     }
  }
//+------------------------------------------------------------------+

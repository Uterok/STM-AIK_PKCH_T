unit ZVA8_Class;

interface
uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
Dialogs, StdCtrls, Mask, ExtCtrls;

type
    rszva = class

      public
        Instrument_Handle : pointer;
        function RESET() : Integer;




        constructor rszva(Resource_Name : string;
                          ID_Query : word;
                          Reset_Device : word);


end;

type
    PInvoke = class

      private
        function InitZVA( Resource_Name : string;
                   ID_Query : word;
                   Reset_Device : word;
                   out Instrument_Handle : pointer
                        ): Integer; stdcall;

        function RESET( {out} Instrument_Handle : pointer
                        ): Integer ; stdcall;

        function GetMarkerOut(  Instrument_Handle : pointer ;
                      Channel__Trace_  : integer;
                      Marker    : integer;
                      out Marker_Response : array of double
                        ): Integer; stdcall;

        function SetDisplayUpdate( Instrument_Handle : pointer;
                           Display_Update  : integer
                        ): Integer; stdcall;

        function TraceExportDataWithOptionsExt
                    (  Instrument_Handle : pointer ;
                       Trace_Name  : string;
                      File_Name: string;
                      Export_Format : integer ;
                      Export_Data : integer;
                      Decimal_Separator : integer ;
                      Field_Separator : integer
                      ): Integer; stdcall;

        function SetupRecall(  Instrument_Handle : pointer ;
                      File_Name : string
                        ): Integer; stdcall;

        function SetupSave(  Instrument_Handle : pointer ;
                      File_Name : string
                        ): Integer; stdcall;



end;



implementation



{ pInvoke }////////////////////////////////////////////////////////////////////////////////////////////////////////

    function PInvoke.InitZVA( Resource_Name : string;
                      ID_Query : word;
                      Reset_Device : word;
                      out Instrument_Handle : pointer
                            ): Integer; stdcall;
                          external 'rszvb_32.dll' index 1227;

    function PInvoke.RESET( {out} Instrument_Handle : pointer
                            ): Integer ; stdcall;
                          external 'rszvb_32.dll' index 1230;

    function PInvoke.GetMarkerOut(  Instrument_Handle : pointer ;
                      Channel__Trace_  : integer;
                      Marker    : integer;
                      out Marker_Response : array of double
                        ): Integer; stdcall;
                      external 'rszvb_32.dll' index 305;

    function PInvoke.SetDisplayUpdate( Instrument_Handle : pointer;
                           Display_Update  : integer
                        ): Integer; stdcall;
                      external 'rszvb_32.dll' index 779;

    function PInvoke.TraceExportDataWithOptionsExt
                    (  Instrument_Handle : pointer ;
                       Trace_Name  : string;
                      File_Name: string;
                      Export_Format : integer ;
                      Export_Data : integer;
                      Decimal_Separator : integer ;
                      Field_Separator : integer
                      ): Integer; stdcall;
                      external 'rszvb_32.dll' index 1182;

    function PInvoke.SetupRecall(  Instrument_Handle : pointer ;
                      File_Name : string
                        ): Integer; stdcall;
                      external 'rszvb_32.dll' index 1140;

    function PInvoke.SetupSave(  Instrument_Handle : pointer ;
                      File_Name : string
                        ): Integer; stdcall;
                      external 'rszvb_32.dll' index 1141;


{ rszva }///////////////////////////////////////////////////////////////////////////////

constructor rszva.rszva(Resource_Name: string; ID_Query, Reset_Device: word);
var
  Result : Integer;
  dllLoad : LongWord;
  m_instr_PInvoke : PInvoke;
begin
  dllLoad := LoadLibrary('rszvb_32.dll');
  if dllLoad = 1 then
  begin
     Result := m_instr_PInvoke.InitZVA(Resource_Name, ID_Query, Reset_Device, Self.Instrument_Handle);
  end

end;

function rszva.RESET() : Integer;
var
  m_instr_PInvoke : PInvoke;
begin
  Result := m_instr_PInvoke.RESET(Self.Instrument_Handle);
end;








end.

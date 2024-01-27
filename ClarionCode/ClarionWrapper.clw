PROGRAM

OMIT('***')
 * Created with Clarion 10.0
 * User: Jeremy McKee
 * Date: 1/4/2019
 * Time: 8:30 AM
 * 
 ***

        MAP
            MODULE('DotNetLibrary')
StringCallbackProcedure PROCEDURE(*BSTRING),TYPE,PASCAL,DLL(TRUE) ! Define the signature of the imported .NET delegate.
DotNetProcedure   PROCEDURE(*StringCallbackProcedure,*StringCallbackProcedure, BSTRING, BSTRING),name('DotNetProcedure'),PASCAL,RAW,DLL(true) ! Define the procedure exported from the .NET dll.
            END
OnError     PROCEDURE  (*BSTRING message),PASCAL ! Define our on-error handler.
OnSuccess   PROCEDURE  (*BSTRING message),PASCAL ! Define our on-success handler.
CallDotNetProcedure    PROCEDURE(BSTRING, BSTRING),PASCAL,DLL(true) ! Local procedure which can be exported.
        END
  CODE
       
CallDotNetProcedure PROCEDURE(BSTRING id, BSTRING stringdata)
    CODE        
        ! Call our .NET method.
        DotNetProcedure(OnSuccess, OnError, id, stringdata)        
        
OnError              PROCEDURE(*BSTRING message)
    CODE
        ! Show the error message.
        MESSAGE('Error: ' & message)         
                    
OnSuccess            PROCEDURE(*BSTRING message)
    CODE
        ! Show the success message.
        MESSAGE('Success: ' & message)
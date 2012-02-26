# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=BEGIN MACROS=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

# adding inbin directory to paths
PATH                   =$(iBN);$(PATH)
INCLUDE                =$(iBN);$(INCLUDE)
LIB                    =$(iBN);$(LIB)

# sub-directory macros
SRC                    =$(MAKEDIR)/src
iBN                    =$(MAKEDIR)/inbin
oBN                    =$(MAKEDIR)/outbin

# DirectX directories (OLD: SETUP DirectX 8.x environment for command line. Fix directory name if incorrect!)
# winINCLUDE             =/dxsdk/INCLUDE
winLIB                 =C:/Program Files/Microsoft DirectX SDK (June 2010)/LIB/x86
# Objects
winOBJ                 =ddraw.lib dinput.lib dxguid.lib


# SDL directories WINDOWS (WINDOWS ONLY)
sdlINCLUDE             =C:/Program Files/Microsoft Visual Studio 10.0/VC/lib/
sdlLIB                 =C:/Program Files/Microsoft Visual Studio 10.0/VC/include/SDL
# Objects (WINDOWS ONLY)
sdlOBJ                 =sdl.lib sdlmain.lib opengl32.lib glu32.lib
# SDL root dir (UNIX, WINDOWS)


# Compiler/assembler/linker directories
VSTUDIO                =
MinGW                  =C:/MinGW/bin

# Per-Program Flags
masmFLAGS              =/Fo$(@R) /c /coff
nasmFLAGS              =-o $(@) -f win32

clFLAGS                =/Fo$(@R) /c /J
gccFLAGS               =-o $(@) -c -funsigned-char `sdl-config --cflags`

clMacroPre             =/D
gccMacroPre            =-D" "

linkFLAGS              =/out:$(@)
ldFLAGS                =-o $(@) `sdl-config --libs`
# [XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]
# [XXXXXXXXXXXXXXXXXXXXXXX=CHANGE BELOW FOR UNIX COMPILING=XXXXXXXXXXXXXXXXXXXXXXXX]
# [XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]
# Compiler Choices
AsmName                =masm #winSDK: =masm #GCC: =nasm _NOT gas_
CPP                    =cl   #winSDK: =cl   #GCC: =gcc
LNK                    =link #winSDK: =LNK  #GCC: =ld

#  Graphics Codepath
GFXdep                 =win #DirectX: =win SDL: =sdl
# [XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]
# [XXXXXXXXXXXXXXXXXXXXXXX=CHANGE ABOVE FOR UNIX COMPILING=XXXXXXXXXXXXXXXXXXXXXXXX]
# [XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX]

# Conditionl Hacks
!IF "$(AsmName)"=="masm"
AS=ml
AFLAGS                 =$(masmFLAGS) #$($(AsmName)FLAGS)
ifVSTUDIO              =true
!ELSE
AS=$(AsmName)
!IF "$(AsmName)"=="nasm"
AFLAGS                 =$(nasmFLAGS) #$($(AsmName)FLAGS)
ifMinGW                =true
!ENDIF
!ENDIF

!IF "$(CPP)"=="cl"
CPPFLAGS               =$(clFLAGS) #$($(CPP)FLAGS)
CMacroPre              =$(clMacroPre) #$($(CPP)MacroPre)
ifVSTUDIO              =true
!ELSEIF "$(CPP)"=="gcc"
CPPFLAGS               =$(gccFLAGS) #$($(CPP)FLAGS)
CMacroPre              =$(gccMacroPre) #$($(CPP)MacroPre)
ifMinGW                =true
!ENDIF

!IF "$(LNK)"=="link"
LNKFLAGS               =$(linkFLAGS) #$($(LNK)FLAGS)
ifVSTUDIO              =true
!ELSEIF "$(LNK)"=="ld"
LNKFLAGS               =$(ldFLAGS) #$($(LNK)FLAGS)
ifMinGW                =true
!ENDIF

!IFDEF VSTUDIO
PATH                   =$(VSTUDIO);$(PATH)
!ENDIF
!IFDEF MinGW
PATH                   =$(MinGW);$(PATH)
!ENDIF

!IF "$(GFXdep)"=="win"
INCLUDE                =$(winINCLUDE);$(INCLUDE) #$($(GFXdep)INCLUDE);$(INCLUDE)
LIB                    =$(winLIB);$(LIB) #$($(GFXdep)LIB);$(LIB)
OBJ                    =$(winOBJ) #$($(GFXdep)OBJ)
!ELSEIF "$(GFXdep)"=="sdl"
INCLUDE                =$(sdlINCLUDE);$(INCLUDE) #$($(GFXdep)INCLUDE);$(INCLUDE)
LIB                    =$(sdlLIB);$(LIB) #$($(GFXdep)LIB);$(LIB)
GFXOBJ                 =$(sdlOBJ) #$($(GFXdep)OBJ)
!ENDIF

# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=END MACROS=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

default:    $(oBN)/game.exe    $(oBN)/simple.exe $(oBN)/voxed.exe $(oBN)/kwalk.exe
# $(oBN)/ $(**B)

# executable (.exe) (meta)targets
$(oBN)/game.exe:       $(oBN)/game.obj   $(oBN)/voxlap5.obj $(oBN)/v5.obj $(oBN)/kpLIB.obj $(oBN)/$(GFXdep)main1.obj;
    $(LNK) $(LNKFLAGS) $(oBN)/game.obj   $(oBN)/voxlap5.obj $(oBN)/v5.obj $(oBN)/kpLIB.obj $(oBN)/$(GFXdep)main1.obj $(GFXOBJ) ole32.lib user32.lib gdi32.lib

$(oBN)/simple.exe:     $(oBN)/simple.obj $(oBN)/voxlap5.obj $(oBN)/v5.obj $(oBN)/kpLIB.obj $(oBN)/$(GFXdep)main1.obj;                     
    $(LNK) $(LNKFLAGS) $(oBN)/simple.obj $(oBN)/voxlap5.obj $(oBN)/v5.obj $(oBN)/kpLIB.obj $(oBN)/$(GFXdep)main1.obj $(GFXOBJ) ole32.lib user32.lib gdi32.lib

$(oBN)/voxed.exe:      $(oBN)/voxed.obj  $(oBN)/voxlap5.obj $(oBN)/v5.obj $(oBN)/kpLIB.obj $(oBN)/$(GFXdep)main2.obj;                     
    $(LNK) $(LNKFLAGS) $(oBN)/voxed.obj  $(oBN)/voxlap5.obj $(oBN)/v5.obj $(oBN)/kpLIB.obj $(oBN)/$(GFXdep)main2.obj $(GFXOBJ)           user32.lib gdi32.lib comdlg32.lib

$(oBN)/kwalk.exe:      $(oBN)/kwalk.obj  $(oBN)/voxlap5.obj $(oBN)/v5.obj $(oBN)/kpLIB.obj $(oBN)/$(GFXdep)main2.obj;                     
    $(LNK) $(LNKFLAGS) $(oBN)/kwalk.obj  $(oBN)/voxlap5.obj $(oBN)/v5.obj $(oBN)/kpLIB.obj $(oBN)/$(GFXdep)main2.obj $(GFXOBJ) ole32.lib user32.lib gdi32.lib comdlg32.lib


# binary object (.obj) targets

# Primary Objects
$(oBN)/game.obj:       $(SRC)/game.cpp   $(SRC)/voxlap5.h $(SRC)/sysmain.h;
    $(CPP) $(CPPFLAGS) $(SRC)/game.cpp
#   used to use /QIfist

$(oBN)/simple.obj:     $(SRC)/simple.cpp $(SRC)/voxlap5.h $(SRC)/sysmain.h;
    $(CPP) $(CPPFLAGS) $(SRC)/simple.cpp
#   used to use /QIfist

$(oBN)/voxed.obj:      $(SRC)/voxed.cpp  $(SRC)/voxlap5.h $(SRC)/sysmain.h;
    $(CPP) $(CPPFLAGS) $(SRC)/voxed.cpp

$(oBN)/kwalk.obj:      $(SRC)/kwalk.cpp  $(SRC)/voxlap5.h $(SRC)/sysmain.h;
    $(CPP) $(CPPFLAGS) $(SRC)/kwalk.cpp

# Secondary Objects
$(oBN)/voxlap5.obj:    $(SRC)/voxlap5.cpp $(SRC)/voxlap5.h;
    $(CPP) $(CPPFLAGS) $(SRC)/voxlap5.cpp

$(oBN)/v5.obj:         $(SRC)/v5.$(AsmName);
    $(AS)  $(AFLAGS)   $(SRC)/v5.$(AsmName)

$(oBN)/kpLIB.obj:      $(SRC)/kpLIB.cpp;
    $(CPP) $(CPPFLAGS) $(SRC)/kpLIB.cpp

$(oBN)/winmain1.obj:   $(SRC)/winmain.cpp $(SRC)/sysmain.h;
    $(CPP) $(CPPFLAGS) $(SRC)/winmain.cpp $(CMacroPre)USEKZ $(CMacroPre)ZOOM_TEST

$(oBN)/winmain2.obj:   $(SRC)/winmain.cpp $(SRC)/sysmain.h;
    $(CPP) $(CPPFLAGS) $(SRC)/winmain.cpp $(CMacroPre)NOSOUND

$(oBN)/sdlmain1.obj:   $(SRC)/sdlmain.cpp $(SRC)/sysmain.h;
    $(CPP) $(CPPFLAGS) $(SRC)/sdlmain.cpp $(CMacroPre)USEKZ $(CMacroPre)ZOOM_TEST

$(oBN)/sdlmain2.obj:   $(SRC)/sdlmain.cpp $(SRC)/sysmain.h;
    $(CPP) $(CPPFLAGS) $(SRC)/sdlmain.cpp $(CMacroPre)NOSOUND

# Clearn Script
clean:
    del "winbuild - debug.txt"
    del asmcompare.txt
    cd $(oBN)
    del *.exe *.obj
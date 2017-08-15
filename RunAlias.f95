! This Program is used to add run options for your System.
! Programmed by Diandong Tang 7/31/2017
! tangdd@mail.bnu.edu.cn

Program RunAlias

    implicit none

!   This is user input, at menu.
    character*200 :: userinput1

!   internal control
    integer :: can_we_go

!   The Program Begins!

!   Banner
    call Banner()

    can_we_go = 0
    do while (can_we_go < 1)

!   Read user input
    Read(*,*) userinput1
    if (userinput1 == "1") then
        can_we_go = can_we_go + 1
        call SYSTEM("cls")
        call Add()
    elseif (userinput1 == "2") then
        Stop
    else
        call SYSTEM("cls")
        call Banner()
        Write(*,*) "Man, Try Enter 1 or 2."
        Write(*,*)
    end if

    end do

End Program RunAlias


!======================================================
Subroutine Banner()

    implicit none

    Write(*,*) "RunAlias"
    Write(*,*) "Programmed by Diandong Tang 7/31/2017"
    Write(*,*) "=========================================="
    Write(*,*) "Please Note that this Program is needed to be run in Administrator Mode."
    Write(*,*) ""
    Write(*,*) "1- Add an Alias to Run."
    Write(*,*) "2- Exit."
    Write(*,*) ""
    Write(*,*) "Please Enter a Number to Continue."
    Write(*,*)

End Subroutine Banner

!======================================================
Subroutine Add()

    implicit none

!   The command you would like to use
    character*200 :: command
    character*200 :: route

!   internal control
    integer :: can_we_go,sysinfo
    character*200 :: userinput2
    character*200 :: the_command,key,keytype

    key="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
    keytype="REG_SZ"

!   Begins!
    can_we_go = 3
    command = " "
    route = " "
    do while (can_we_go > 0)

!   User input Section
    Write(*,*) "RunAlias"
    Write(*,*) "Programmed by Diandong Tang 7/31/2017"
    Write(*,*) "=========================================="
    Write(*,*) "Executable:"
    Write(*,*) ""
    Write(*,*) route
    Write(*,*) "=========================================="
    Write(*,*) "Alias:"
    Write(*,*) ""
    Write(*,*) command
    Write(*,*) "=========================================="
    Write(*,*) "Instruction:"

    if (can_we_go == 1) then
        Write(*,*) "Is this OK?(y/n)."
        Read(*,*) userinput2
        if (userinput2 == 'y') then
            can_we_go = can_we_go - 1
            call SYSTEM("cls")
        elseif (userinput2 == 'n') then
            can_we_go = can_we_go + 2
        else
            can_we_go = can_we_go
            call SYSTEM("cls")
        end if
    end if

    if (can_we_go == 2) then
        Write(*,*) "Please Enter the Alias."
        Write(*,*) ""
        Read(*,*) command
        can_we_go = can_we_go - 1
        call SYSTEM("cls")
    end if

    if (can_we_go == 3) then
        Write(*,*) "Please enter the Executable Path, and press Enter."
        Write(*,*) ""
        Read(*,*) route
        can_we_go = can_we_go - 1
        call SYSTEM("cls")
    end if

    end do

!   Make the DOS Command

    Write(the_command,"('%SystemRoot%\System32\reg.exe ADD ""',a,'\',a,'.exe"" /f /t ',a,' /d ',a,' ')") &
    & trim(adjustl(key)),trim(adjustl(command)),trim(adjustl(keytype)),trim(adjustl(route))

!    Write(the_command,"('%SystemRoot%\System32\reg.exe ADD ""',a,'\',a,'.exe"" /v Path /t ',a,' /d ',a,' ')") &
!    & trim(adjustl(key)),trim(adjustl(command)),trim(adjustl(keytype)),trim(adjustl(route))

    Write(*,*) "Executing RegAdd..."
    write(*,*)trim(adjustl(the_command))

!   Execute the Command

    CALL SYSTEM(the_command, sysinfo)

!   See whether it worked
    if (sysinfo==0) then
        Write(*,*) "Alias Successfully Set."
        Read(*,*)
    else
        Write(*,*) "Trouble setting the alias. Probably not in Administrator Mode?"
        Read(*,*)
        stop
    end if

    open(10,file='RunAlias.log',status='unknown',position='append')

    write(10,*)trim(adjustl(command))
    write(10,*)trim(adjustl(route))
    write(10,*)"=========================================="

    close(10)

End Subroutine Add






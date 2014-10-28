program a
    implicit none
    integer :: unit_out=10, unit_table=20
    character(80)::datastr1='YEAR MNTH DAYS HOUR MINU SECO'
    character(80)::datastr2='CLAT CLON SAID SIID FOVN LSQL'
    character(80)::datastr3='SAZA SOZA HOLS HMSL'
    character(80)::datastr4='CHNM TMBR CSTC'
    real(8)::data1(6),data2(6),data3(4),data4(3,15)
    
    integer::ireadmg, ireadsb
    character(8) subset
    integer::unit_in=10,i
    integer::idate,iret,num_message,num_subset

    open(unit_in,file='bufr2',action='read',form='unformatted')
    call openbf(unit_in,'IN',unit_in)
    call datelen(10)

        num_message=0
        msg_report: do while (ireadmg(unit_in,subset,idate)==0)
            num_message=num_message+1
            num_subset=0
!            write(*,'(I10,I4,a10)') idate,num_message,subset
            sb_report: do while (ireadsb(unit_in)==0)
                num_subset=num_subset+1
                call ufbint(unit_in,data1,6,1,iret,datastr1)
                call ufbint(unit_in,data2,6,1,iret,datastr2)
                call ufbint(unit_in,data3,4,1,iret,datastr3)
                call ufbrep(unit_in,data4,3,15,iret,datastr4)

                write(*,'(2I8,6f20.5)') num_subset,iret,data1
!                write(*,'(2I8,6f20.5)') num_subset,iret,data2
!                write(*,'(2I8,4f20.5)') num_subset,iret,data3

                do i=1,15,1
!                    write(*,'(2I8,3f20.5)') num_subset,iret,data4(1:3,i)
                enddo

            enddo sb_report
        enddo msg_report
        call closbf(unit_in)
end

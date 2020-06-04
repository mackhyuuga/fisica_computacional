program three_bodies
    implicit none

    !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- variables =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-!
    ! 'n' is the number of iterations, it is given by the time divided by interval 'h'           !
    ! 'f' represents the number of functions that the system solves                              !
    ! 'g','i' and 'w' are just iteration variables                                               ! 
    !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=!
    !                                                                                            !
    real (kind = 8), dimension(:,:), allocatable  :: k, results
    real (kind = 8), dimension(:), allocatable :: func, x, x0
    real (kind = 8) :: h, t, t0
    integer :: n, g, i, f, w

    character(len = 80) :: input, output

    real (kind = 8) :: m(3) ! mass
    !                                                                                            !
    !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=!
    !-=-=-=-=- declaring the number of functions that the software will have to solver -=-=-=-=-=!
        f = 12       
    !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=!

    allocate(k(4,f), func(f), x(f), x0(f))
    
    call read   

    allocate(results(n+1,f+1))

    call runge_kutta

    call write

    deallocate(k, func, x, x0, results)


    contains

    subroutine read 

        write(*,*) 'enter the name of the file containing the initial conditions: '
        read(*,*) input
        input = adjustl(trim(input)) // '.txt'
        open(20, file = input, form='formatted', status='old')

        read(20,*) h            ! interval
        read(20,*) t            ! time
        read(20,*) m(1)         ! mass of particle 1
        read(20,*) m(2)         ! mass of particle 2
        read(20,*) m(3)         ! mass of particle 3
        read(20,*) x0(1)        ! position of particle 1 on the x axis 
        read(20,*) x0(7)        ! position of particle 1 on the y axis
        read(20,*) x0(2)        ! position of particle 2 on the x axis 
        read(20,*) x0(8)        ! position of particle 2 on the y axis 
        read(20,*) x0(3)        ! position of particle 3 on the x axis 
        read(20,*) x0(9)        ! position of particle 3 on the y axis 
        read(20,*) x0(4)        ! speed of particle 1 on the x axis 
        read(20,*) x0(10)       ! speed of particle 1 on the y axis 
        read(20,*) x0(5)        ! speed of particle 2 on the x axis 
        read(20,*) x0(11)       ! speed of particle 2 on the y axis 
        read(20,*) x0(6)        ! speed of particle 3 on the x axis 
        read(20,*) x0(12)       ! speed of particle 3 on the y axis 
    
        close(20) 

        n = nint(t/h) 

    end subroutine read

    subroutine runge_kutta

        do g = 1, n

        !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= calculating the kn -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=!
        !                                                                                            !     

                ! k1
                    t = t0
                        x(:) = x0(:)
                    call gravity(t, x, func)     
                        k(1,:) = func(:)

                ! k2
                    t = t0 + h/2
                        x(:) = x0(:) + k(1,:)*h/2
                    call gravity(t, x, func)
                        k(2,:) = func(:)

                ! k3
                    t = t0 + h/2
                        x(:) = x0(:) + k(2,:)*h/2
                    call gravity(t, x, func)
                        k(3,:) = func(:)

                ! k4
                    t = t0 + h
                        x(:) = x0(:) + k(3,:)*h
                    call gravity(t, x, func)
                        k(4,:) = func(:)
        !                                                                                            !
        !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=!

        !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- calculating the xn+1 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=!
        !                                                                                            !            
                        x = x0 + h*(k(1,:) + 2*k(2,:) + 2*k(3,:) + k(4,:))/6
        !                                                                                            !           
        !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=!
        
        !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= saving the results =-=-=-=-=-=-=-=-=-=-=-=-=-=--=-=-=-=-=!
        !                                                                                            !   
                    if (g == 1) then
                        do i = 1, f 
                            results(1,i) = x0(i)
                        end do
                        results(1,f+1) = t0
                    end if
                    
                    do i = 1, f
                        results(g+1,i) = x(i)
                    end do
                    results(g+1,f+1) = t
        !                                                                                            !           
        !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=!

                    t0 = t                  ! updating the values for the next iteration 
                    x0(:) = x(:)            

        
        end do
            
    end subroutine runge_kutta
    
    subroutine gravity(t, x, func)
        implicit none
        real (kind = 8), intent(in) :: t, x(:) 
        real (kind = 8), intent(out) ::  func(:)
        real (kind = 8) :: r(9)    
    
        r(1) = x(2) - x(1)
        r(2) = x(8) - x(7)
        r(3) = x(3) - x(1)               !  rx21, ry21, rx31, ry31, rx32, ry32, r21, r31, r32
        r(4) = x(9) - x(7)               !  r(1)  r(2)  r(3)  r(4)  r(5)  r(6)  r(7) r(8) r(9)     
        r(5) = x(3) - x(2)
        r(6) = x(9) - x(8)
    
        r(7) = sqrt(r(1)**2+r(2)**2)
        r(8) = sqrt(r(3)**2+r(4)**2)
        r(9) = sqrt(r(5)**2+r(6)**2)
    
        func(1) = x(4)
        func(2) = x(5)
        func(3) = x(6) 
        func(4) = m(2)*r(1)/(r(7)**3) + m(3)*r(3)/(r(8)**3)
        func(5) = m(3)*r(5)/(r(9)**3) - m(1)*r(1)/(r(7)**3)
        func(6) = -m(1)*r(3)/(r(8)**3) - m(2)*r(5)/(r(9)**3)
        func(7) = x(10)
        func(8) = x(11)
        func(9) = x(12)
        func(10) = m(2)*r(2)/(r(7)**3) + m(3)*r(4)/(r(8)**3)
        func(11) = m(3)*r(6)/(r(9)**3) - m(1)*r(2)/(r(7)**3)
        func(12) = -m(1)*r(4)/(r(8)**3) - m(2)*r(6)/(r(9)**3)
    
    end subroutine gravity

    subroutine write 

        write(*,*) 'enter the name of the file where the values will be saved: '
        read(*,*) output
        output = adjustl(trim(output)) // '.txt'
        open(10, file = output, form='formatted', status='unknown')

        !-=-= the following command only has the function of explaining the meaning of each column in the text file =-=-=!   
        !                                                                                                                !    
                write(10,*) "            r1x                 r1y                 r2x                 r2y   &        
                &              r3x                 r3y                   t    " 
        !                                                                                                                !
        !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=! 

        !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= writing the results =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=! 
        !                                                                                                                ! 
            if (h < 0.01) then      ! this command only has the utility of preventing the program 
                w = nint(0.01/h)    ! from printing a surreal amount of values in the output file
            else 
                w = 1
            end if

            do g = 1, n+1, w

            write(10,30) results(g,1), results(g,7), results(g,2), results(g,8), results(g,3), &
            & results(g,9), results(g,13)

            end do

        !                                                                                                                !
        !-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=!
        
        30 format(f20.8, f20.8, f20.8, f20.8, f20.8, f20.8, f20.8)  
        ! the use of 20 houses is just for organization and legibility


        close(10)

        write(*,*) 'process concluded'

    end subroutine write


end program three_bodies

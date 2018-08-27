--------------------------------------------------------------------------------
-- Project name   :
-- File name      : unit_test.vhd
-- Created date   : Thu 30 Nov 2017 03:18:31 PM +07
-- Author         : Ngoc-Sinh Nguyen
-- Last modified  : Thu 30 Nov 2017 03:18:31 PM +07
-- Desc           :
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

package check_equal_pkg is
    procedure real_equal(expected : real;
                         actual : real;
                        error_percentage : real;
                        level : severity_level := error);

    procedure real_equal(expected : real;
                         actual : real;
                        error_percentage : real;
                        init_error_message : string;
                        level : severity_level := error);


    procedure integer_equal(expected : integer;
                    actual : integer;
                    level : severity_level := error);
     
    procedure integer_equal(expected : integer;
                    actual : integer;
                    init_error_message : string;
                    level : severity_level := error);
                

end package check_equal_pkg;

package body check_equal_pkg is

    procedure real_equal (
            expected : real;
            actual : real;
            error_percentage : real;
            level : severity_level := error
        ) is
    begin
        if actual * expected = 0.0 then
            assert (abs(expected - actual) < error_percentage)
                report "EXPECTED: " & real'image(expected)
                & ",but ACTUAL " & real'image(actual)
                severity level;
        else
            assert (abs(actual - expected) / abs(expected) < error_percentage)
                report "EXPECTED: " & real'image(expected)
                & ",but ACTUAL " & real'image(actual)
                severity level;
        end if;
    end procedure ;

    procedure real_equal (
            expected : real;
            actual : real;
            error_percentage : real;
            init_error_message :  string;
            level : severity_level := error
        ) is
    begin
        if actual * expected = 0.0 then
            assert (abs(expected - actual) < error_percentage)
                report init_error_message
                & ":EXPECTED " & real'image(expected)
                & ",but ACTUAL " & real'image(actual)
                severity level;
        else
            assert (abs(actual - expected) / abs(expected) < error_percentage)
                report init_error_message
                & ":EXPECTED " & real'image(expected)
                & ",but ACTUAL " & real'image(actual)
                severity level;
        end if;
    end procedure ;

    procedure integer_equal (
            expected : integer;
            actual : integer;
            level : severity_level := error
        ) is
    begin
        assert (expected = actual)
            report "EXPECTED: " & integer'image(expected)
            & ",but ACTUAL " & integer'image(actual)
            severity level;
    end procedure ;

    procedure integer_equal (
            expected : integer;
            actual : integer;
            init_error_message : string;
            level : severity_level := error
        ) is
    begin
        assert (expected = actual)
            report init_error_message
            & ":EXPECTED " & integer'image(expected)
            & ",but ACTUAL " & integer'image(actual)
            severity level;
    end procedure ;


end package body;


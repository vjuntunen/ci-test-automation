# SPDX-FileCopyrightText: 2022-2024 Technology Innovation Institute (TII)
# SPDX-License-Identifier: Apache-2.0

*** Settings ***
Resource            ../config/variables.robot
Library             BuiltIn
Library             ../lib/PlugLibrary/PlugLibrary.py  ${PLUG_TYPE}
Library             ../lib/SwitchbotLibrary.py  ${SWITCH_TOKEN}  ${SWITCH_SECRET}

*** Keywords ***

Reboot Device
    [Arguments]       ${delay}=5
    [Documentation]   Turn off power of device, wait for given amount of seconds and turn on the power
    Log To Console    ${\n}Turning device off...
    Turn Plug Off
    Sleep    ${delay}
    Log To Console    Turning device on...
    Turn Plug On

Reboot Device Via Relay
    [Arguments]       ${delay}=5
    [Documentation]   Turn off power of device, wait for given amount of seconds and turn on the power
    Open Relay Serial Port    /dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A10KYI3B-if00-port0
    Log To Console    ${\n}Turning device off...
    Turn Relay Off
    Sleep    ${delay}
    Log To Console    Turning device on...
    Turn Relay On

Reboot LenovoX1
    [Arguments]       ${delay}=20
    [Documentation]   Turn off the laptop by pressing power button for 10 sec turn on by short pressing power button
    ${device_is_available}   Ping Host   ${DEVICE_IP_ADDRESS}
    IF  ${device_is_available}
        Log To Console    ${\n}Turning device off...
        Press Button      ${SWITCH_BOT}-OFF
        Sleep    ${delay}
    END
    Log To Console    Turning device on...
    Press Button      ${SWITCH_BOT}-ON

Soft Reboot Device
    [Documentation]  Reboot device from command line
    ${device_is_available}   Ping Host   ${DEVICE_IP_ADDRESS}
    IF  ${device_is_available}
        Connect to ghaf host
        ${output}  Execute Command  reboot  sudo=True  sudo_password=${password}
        Log  ${output}
        Log To Console  Rebooting device from command line
    END

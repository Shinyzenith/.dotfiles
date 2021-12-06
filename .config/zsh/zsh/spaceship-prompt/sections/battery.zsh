#
# Battery
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# | SPACESHIP_BATTERY_SHOW | below threshold | above threshold | fully charged |
# |------------------------+-----------------+-----------------+---------------|
# | false                  | hidden          | hidden          | hidden        |
# | always                 | shown           | shown           | shown         |
# | true                   | shown           | hidden          | hidden        |
# | charged                | shown           | hidden          | shown         |
# ------------------------------------------------------------------------------

SPACESHIP_BATTERY_SHOW="${SPACESHIP_BATTERY_SHOW=true}"
SPACESHIP_BATTERY_PREFIX="${SPACESHIP_BATTERY_PREFIX=""}"
SPACESHIP_BATTERY_SUFFIX="${SPACESHIP_BATTERY_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_BATTERY_SYMBOL_CHARGING="${SPACESHIP_BATTERY_SYMBOL_CHARGING="⇡"}"
SPACESHIP_BATTERY_SYMBOL_DISCHARGING="${SPACESHIP_BATTERY_SYMBOL_DISCHARGING="⇣"}"
SPACESHIP_BATTERY_SYMBOL_FULL="${SPACESHIP_BATTERY_SYMBOL_FULL="•"}"
SPACESHIP_BATTERY_THRESHOLD="${SPACESHIP_BATTERY_THRESHOLD=10}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show section only if either of follow is true
# - Always show is true
# - battery percentage is below the given limit (default: 10%)
# - Battery is fully charged
# Escape % for display since it's a special character in zsh prompt expansion
spaceship_battery() {
  [[ $SPACESHIP_BATTERY_SHOW == false ]] && return

  local battery_data battery_percent battery_status battery_color

  if spaceship::exists pmset; then
    battery_data=$(pmset -g batt | grep "InternalBattery")

    # Return if no internal battery
    [[ -z "$battery_data" ]] && return
    
    # Colored output from pmset will break prompt if grep is aliased to show colors
    battery_percent="$( echo $battery_data | \grep -oE '[0-9]{1,3}%' )"
    battery_status="$( echo $battery_data | awk -F '; *' '{ print $2 }' )"
  elif spaceship::exists acpi; then
    battery_data=$(acpi -b 2>/dev/null | head -1)

    # Return if no battery
    [[ -z $battery_data ]] && return

    battery_status_and_percent="$(echo $battery_data |  sed 's/Battery [0-9]*: \(.*\), \([0-9]*\)%.*/\1:\2/')"
    battery_status_and_percent_array=("${(@s/:/)battery_status_and_percent}")
    battery_status=$battery_status_and_percent_array[1]:l
    battery_percent=$battery_status_and_percent_array[2]

	# If battery is 0% charge, battery likely doesn't exist.
    [[ $battery_percent == "0" ]] && return

  elif spaceship::exists upower; then
    local battery=$(command upower -e | grep battery | head -1)

    # Return if no battery
    [[ -z $battery ]] && return

    battery_data=$(upower -i $battery)
    battery_percent="$( echo "$battery_data" | grep percentage | awk '{print $2}' )"
    battery_status="$( echo "$battery_data" | grep state | awk '{print $2}' )"
  else
    return
  fi

  # Remove trailing % and symbols for comparison
  battery_percent="$(echo $battery_percent | tr -d '%[,;]')"

  # Change color based on battery percentage
  if [[ $battery_percent == 100 || $battery_status =~ "(charged|full)" ]]; then
    battery_color="green"
  elif [[ $battery_percent -lt $SPACESHIP_BATTERY_THRESHOLD ]]; then
    battery_color="red"
  else
    battery_color="yellow"
  fi

  # Battery indicator based on current status of battery
  if [[ $battery_status == "charging" ]];then
    battery_symbol="${SPACESHIP_BATTERY_SYMBOL_CHARGING}"
  elif [[ $battery_status =~ "^[dD]ischarg.*" ]]; then
    battery_symbol="${SPACESHIP_BATTERY_SYMBOL_DISCHARGING}"
  else
    battery_symbol="${SPACESHIP_BATTERY_SYMBOL_FULL}"
  fi

  # Escape % for display since it's a special character in Zsh prompt expansion
  if [[ $SPACESHIP_BATTERY_SHOW == 'always' ||
        $battery_percent -lt $SPACESHIP_BATTERY_THRESHOLD ||
        $SPACESHIP_BATTERY_SHOW == 'charged' && $battery_status =~ "(charged|full)" ]]; then
    spaceship::section \
      "$battery_color" \
      "$SPACESHIP_BATTERY_PREFIX" \
      "$battery_symbol$battery_percent%%" \
      "$SPACESHIP_BATTERY_SUFFIX"
  fi
}

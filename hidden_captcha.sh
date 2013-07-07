#!/bin/sh
# Enable the module.
drush @sites -y en hidden_captcha
# Log wrong answers.
drush @sites -y vset captcha_log_wrong_responses 1
# Use hidden captcha for all forms.
# Please pay attention to your cache policy.
drush @sites -y sqlq "UPDATE captcha_points SET module = 'hidden_captcha', captcha_type = 'Hidden CAPTCHA' WHERE module is NULL"
# Flush captcha cache.
drush @sites -y vdel captcha_placement_map_cache
# Randomely generate a mah question as the label of the hidden captcha field.
drush @sites -y vset hidden_captcha_label "$RANDOM + $RANDOM"

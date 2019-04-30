#!/usr/bin/env -S jq -r -f
.lvm.vgs as $vgs |
if ($user_specified_vg | length)? > 0 then
  # User has specified a VG. Test if the VG holds more than
  # the minimum amount of GiB. Note that in the following
  # test we have to use the '?' since the user can specify a
  # VG that does not exist. The result is null if so.
  if ($vgs | .[$user_specified_vg] | .free_g | tonumber) > $minimum_gib then
    "\($user_specified_vg)"
  else
    # The user specified VG must be used. If it fails the
    # test for minimum amount of space in GiB then we enter
    # this branch and yield nothing. This way we express
    # that the user has specified an invalid VG.
    empty
  end
else
  (.distribution |
   ascii_downcase) as $distribution_vg |
  if ($vgs | .[$distribution_vg] | .free_g | tonumber) > $minimum_gib then
    "\($distribution_vg)"
  else
    # Sort the VGs with respect to size, i.e. free_g. The
    # largest VG comes first. Bind the largest VG to a
    # variable.
    $vgs |
    to_entries |
    sort_by(.value.free_g | tonumber) |
    reverse as $largest |
    # Test the largest VG against the mimimum amount of GiB
    # required.
    if ($largest[0] | .value.free_g | tonumber) > $minimum_gib then
      "\($largest[0] | .key)"
    else
      empty
    end
  end
end

#!/usr/bin/perl

#use warnings;
#script rank and effects to STDIN

@effects = ( "None", "Blunt Attack", "Edged Attack", "Shooting Attack",						"Throwing Edged", "Throwing Blunt", "Energy", "Force", "Grappling", "Grabbing", "Escaping", "Charging", "Dodging", "Evading", "Blocking", "Catching", "Stun?", "Slam?", "Kill?" );
						
@rank = ( "", "SH0", "FB", "PR", "TY", "GD", "EX", "RM", "IN", "AM", "MN", "UN", "SHX", "SHY", "SHZ", "CL1000", "CL3000","CL5000", "Beyond");

@whiteEffects = ( "WHITE", "MISS", "MISS", "MISS", "MISS", "MISS", "MISS", "MISS", "MISS", "MISS", "MISS", "MISS", "NONE", "AUTOHIT", "-6 CS", "AUTOHIT", "1-10", "GRAND SLAM","ENDURANCE LOSS" );
						
@greenEffects = ( "GREEN", "HIT", "HIT", "HIT", "HIT", "HIT", "HIT", "HIT", "MISS", "TAKE", "MISS", "HIT", "-2 CS", "EVASION", "-4 CS", "MISS", "1", "1 AREA", "E/S (EDGED/SHOOTING)" );

@yellowEffects = ( "YELLOW", "SLAM", "STUN", "BULLSEYE", "STUN", "HIT",	"BULLSEYE", "BULLSEYE", "Partial", "GRAB", "ESCAPE", "SLAM", "-4 CS", "+1 CS", "-2 CS", "DAMAGE", "NO",	"STAGGER", "NO" );

@redEffects = ( "RED", "STUN", "KILL", "KILL", "KILL", "STUN", "KILL","STUN", "HOLD", "BREAK", "REVERSE", "STUN", "-6 CS", "+2 CS", "+1 CS", "CATCH", "NO", "NO", "NO" );

# Advanced Universal Table
@universaltable =	('"SH0", -1, 66, 95, 100',
				'"FB",  -1, 61, 91, 100',
				'"PR",  -1, 56, 86, 100',
				'"TY",  -1, 51, 81, 98',
				'"GD",  -1, 46, 76, 98',
				'"EX",  -1, 41, 71, 95',
				'"RM",  -1, 36, 66, 95',
				'"IN",  -1, 31, 61, 91',
				'"AM",  -1, 26, 56, 91',
				'"MN",  -1, 21, 51, 86',
				'"UN",  -1, 16, 46, 86',
				'"SHX", -1, 11, 41, 81',
				'"SHY", -1, 7, 41, 81',
				'"SHZ", -1, 4, 36, 76',
				'"CL1000", -1, 2, 36, 76',
				'"CL3000", -1, 2, 31, 71',
				'"CL5000", -1, 2, 26, 66',
				'"Beyond", -1, 2, 21, 61');



$d100 = int(rand(100)) + 1;

print " \n";

print "CHOOSE EFFECT \n";

$counteffect = 0;
foreach $effect (@effects)
{
  print "$counteffect: $effect  ";
  $counteffect++;
}
print "\n";

$chosenEffect = <STDIN>;
chomp($chosenEffect);
while ( $chosenEffect =~m/[^0-9]/ || $chosenEffect > 18)
{
  print "CHOOSE EFFECT \n";
  $chosenEffect = <STDIN>;
  chomp($chosenEffect);

}

print "Effect = $effects[$chosenEffect]\n\n";

print "CHOOSE RANK \n";
$countrank = 0;
foreach $rank (@rank)
{
  print "$countrank: $rank  ";
  $countrank++;
}
print "\n";

$chosenRank = <STDIN>;
chomp($chosenRank);
while ( $chosenRank =~m/[^0-9]/ || $chosenRank > 18)
{
  print "CHOOSE RANK \n";
  $chosenRank = <STDIN>;
  chomp($chosenRank);
}

print "Rank = $rank[$chosenRank] - $effects[$chosenEffect] - ";

$d100Result = "WHITE";
$colorResult = $whiteEffects[$chosenEffect];

foreach $column (@universaltable)
{
  
  if ($column =~m/$rank[$chosenRank]/)
  {
    #found rank column
    @column = split(/,/, $column);
        
    $columnRank = $column[0];
    $columnWhite = $column[1];
    $columnGreen = $column[2];
    $columnYellow = $column[3];
    $columnRed = $column[4];
    
    if ($d100 >= $columnGreen)
    {
      $d100Result = "GREEN";
      $colorResult = $greenEffects[$chosenEffect];
    }
    if ($d100 >= $columnYellow)
    {
      $d100Result = "YELLOW";
      $colorResult = $yellowEffects[$chosenEffect];
    }
    if ($d100 >= $columnRed)
    {
      $d100Result = "RED";
      $colorResult = $redEffects[$chosenEffect];
    }
    print "Roll : $d100 - $d100Result - $colorResult\n";
    last;
  }

}


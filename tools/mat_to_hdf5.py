import scipy.io as sio
import h5py
import numpy as np

# --- Configuration ---
mat_file_path = 'AP4_Control_Workspace.mat'  # Replace with the path to your .mat file
hdf5_file_path = 'AP4_Control_Workspace.h5' # Replace with desired HDF5 file name

# --- Helper function to recursively write data to HDF5 ---
def write_to_hdf5_recursive(hdf5_group, data, name):
    """
    Recursively writes data (NumPy arrays, dictionaries, etc.) to an HDF5 group.

    Args:
        hdf5_group: The h5py Group object to write data into.
        data: The data to write (can be NumPy array, dictionary, or other types).
        name: The name to give the data/group within the HDF5 group.
    """
    # Handle NumPy arrays
    if isinstance(data, np.ndarray):
        # Check for object dtype
        if data.dtype == 'O':
            print(f"  Handling object dtype array for '{name}'...")
            # If it's an object array, iterate through its elements
            # This is common for MATLAB cell arrays or structs loaded by scipy.io
            if data.shape == (1, 1):
                # Handle 1x1 object arrays, often containing a single struct or cell
                print(f"  Processing 1x1 object array for '{name}'...")
                write_to_hdf5_recursive(hdf5_group, data[0, 0], name)
            elif data.ndim == 2 and data.shape[0] == 1:
                 # Handle 1xN object arrays (common for cell arrays)
                 print(f"  Processing 1xN object array (potential cell array) for '{name}'...")
                 group = hdf5_group.create_group(name)
                 for i, element in enumerate(data[0]):
                      write_to_hdf5_recursive(group, element, f'element_{i}')
            elif data.ndim == 2 and data.shape[1] == 1:
                 # Handle Nx1 object arrays (potential cell arrays)
                 print(f"  Processing Nx1 object array (potential cell array) for '{name}'...")
                 group = hdf5_group.create_group(name)
                 for i, element in enumerate(data[:, 0]):
                      write_to_hdf5_recursive(group, element, f'element_{i}')
            else:
                # Handle other shapes of object arrays - might need specific logic
                print(f"  Warning: Unhandled object array shape {data.shape} for '{name}'. Skipping.")
        else:
            # Write standard NumPy arrays directly as datasets
            try:
                hdf5_group.create_dataset(name, data=data)
                print(f"  Created dataset '{name}'")
            except TypeError as e:
                 print(f"  Error creating dataset '{name}' with dtype {data.dtype}: {e}")
                 # Attempt to convert to a compatible type if possible (e.g., string)
                 try:
                     if data.dtype.kind in ['U', 'S']: # Unicode or byte string
                          # Convert array of strings to a list of strings
                          str_data = [str(x) for x in np.flatten(data)]
                          # Create a dataset for strings (h5py handles lists of strings)
                          hdf5_group.create_dataset(name, data=str_data, dtype=h5py.string_dtype())
                          print(f"  Created string dataset '{name}'")
                     else:
                          print(f"  Could not automatically handle TypeError for dtype {data.dtype}.")
                 except Exception as inner_e:
                      print(f"  Error attempting alternative write for '{name}': {inner_e}")


    # Handle dictionaries (often represent MATLAB structs)
    elif isinstance(data, dict):
        print(f"  Handling dictionary (potential struct) for '{name}'...")
        group = hdf5_group.create_group(name)
        print(f"  Created group '{name}'")
        for key, value in data.items():
            write_to_hdf5_recursive(group, value, key)

    # Handle other data types (e.g., scalar values, strings not in arrays)
    # You might need to add specific handling for other types if loadmat returns them
    elif isinstance(data, (int, float, str)):
         try:
             hdf5_group.create_dataset(name, data=data)
             print(f"  Created scalar dataset '{name}'")
         except Exception as e:
              print(f"  Error creating scalar dataset '{name}': {e}")

    else:
        print(f"  Warning: Skipping unsupported data type {type(data)} for '{name}'")


# --- Load data from the .mat file ---
try:
    print(f"Loading data from {mat_file_path}...")
    # Use variable_names=None to load all variables
    mat_data = sio.loadmat(mat_file_path, variable_names=None)
    print("Data loaded successfully.")
    # print("Loaded variables:", mat_data.keys()) # Uncomment to see variable names
except FileNotFoundError:
    print(f"Error: .mat file not found at {mat_file_path}")
    exit()
except Exception as e:
    print(f"Error loading .mat file: {e}")
    exit()

# --- Write data to the HDF5 file ---
try:
    print(f"Creating HDF5 file: {hdf5_file_path}")
    # Use 'w' mode to create a new file or overwrite if it exists
    with h5py.File(hdf5_file_path, 'w') as f:
        # Iterate through the loaded data (a dictionary)
        for var_name, var_data in mat_data.items():
            # Skip the metadata entries that scipy.io.loadmat often includes
            if var_name.startswith('__'):
                continue

            print(f"Processing variable '{var_name}'...")
            # Use the recursive function to write the data
            write_to_hdf5_recursive(f, var_data, var_name)

    print(f"Data successfully transported to {hdf5_file_path}")

except Exception as e:
    print(f"An error occurred during HDF5 writing: {e}")

